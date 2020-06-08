//
//  KMAweatherClient.swift
//  Moning
//
//  Created by 이제인 on 2020/06/05.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import CoreLocation

class KMAweatherClient {
    
    static let apiKey = "ServiceKey=WlFbddIA5I1gY%2BO8cyfSL1u9PK0o0BD06jw%2FxSAroIkdaLfMpNY5c7zv%2F%2FSEnpl5SS17Wh7wImc0IF1GxAiyFA%3D%3D&ServiceKey=-"
    
    static func coorString(lat: CLLocationDegrees, lon: CLLocationDegrees) -> String {
           convertCoor(lat: lat, lon: lon)
           return "&nx="+String(Place.nx)+"&ny="+String(Place.ny)
    }
    
    // 위도경도 -> 기상청좌표 변환
    static func convertCoor(lat: CLLocationDegrees, lon: CLLocationDegrees){
           let RE = 6371.00877 // 지구 반경(km)
           let GRID = 5.0 // 격자 간격(km)
           let SLAT1 = 30.0 // 투영 위도1(degree)
           let SLAT2 = 60.0 // 투영 위도2(degree)
           let OLON = 126.0 // 기준점 경도(degree)
           let OLAT = 38.0 // 기준점 위도(degree)
           let XO:Double = 43 // 기준점 X좌표(GRID)
           let YO:Double = 136 // 기1준점 Y좌표(GRID)
           
           let DEGRAD = Double.pi / 180.0
           let RADDEG = 180.0 / Double.pi
           
           let re = RE / GRID
           let slat1 = SLAT1 * DEGRAD
           let slat2 = SLAT2 * DEGRAD
           let olon = OLON * DEGRAD
           let olat = OLAT * DEGRAD
           
           var sn = tan(Double.pi * 0.25 + slat2 * 0.5) / tan(Double.pi * 0.25 + slat1 * 0.5)
           sn = log(cos(slat1) / cos(slat2)) / log(sn)
           var sf = tan(Double.pi * 0.25 + slat1 * 0.5)
           sf = pow(sf, sn) * cos(slat1) / sn
           var ro = tan(Double.pi * 0.25 + olat * 0.5)
           ro = re * sf / pow(ro, sn)
           
           var lat_X = Double(lat)
           var lng_Y = Double(lon)
           
           var ra = tan(Double.pi * 0.25 + lat_X * DEGRAD * 0.5)
           ra = re * sf / pow(ra, sn)
           var theta = lng_Y * DEGRAD - olon
           if theta > Double.pi {
               theta -= 2.0 * Double.pi
           }
           if theta < -Double.pi {
               theta += 2.0 * Double.pi
           }
           
           theta *= sn
           Place.nx = Int(floor(ra * sin(theta) + XO + 0.5))
           Place.ny = Int(floor(ro - ra * cos(theta) + YO + 0.5))
    }
    
    
    // API 1 : 초단기실황 -> 현재 기온
    static let nowcastBase = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtNcst?"
    static let nowcastType = "&pageNo=1&numOfRows=10&dataType=json"
    
    static func nowcastTimeString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: date)

        let timeString: String
        // 0분~40분: 그 전 시간 59분
        if (0 <= components.minute! && components.minute! <= 40) {
            dateFormatter.dateFormat = "HH"
            timeString = dateFormatter.string(from: date-3600) + "59"
        }
        // 41분~59분: 그대로
        else {
            dateFormatter.dateFormat = "HHmm"
            timeString = dateFormatter.string(from: date)
        }

        return "&base_date="+dateString+"&base_time="+timeString
    }
    
    static func nowcastUrl(lat: CLLocationDegrees, lon: CLLocationDegrees) -> URL{
        return URL(string: self.nowcastBase+self.apiKey+self.nowcastType+self.nowcastTimeString()+self.coorString(lat: lat, lon: lon))!
    }
    
    static func getCurrentTemp(){
        let url = self.nowcastUrl(lat: Place.lat, lon: Place.lon)
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
            guard let data = data else { return }
            print(data)
            
            let decoder = JSONDecoder()
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                else {
                    print("json error")
                    return
                }
            
            let resp = jsonData["response"] as! [String:Any]
            let hdr = resp["header"] as! [String:Any]
            let rslt = hdr["resultCode"] as! String
            
            if rslt != "00" {
                print("result code error")
                return
            }
            
            let bd = resp["body"] as! [String:Any]
            let items = bd["items"] as! [String:Any]
            let item = items["item"] as! [[String:Any]]
            
            var cnt = 0
            for i in item {
                let data = i as [String:Any]
                
                let cat = data["category"] as! String
                
                // 현재기온
                if cat == "T1H" {
                    MainWeather.timeStamp = (data["baseDate"] as! String)+" "+(data["baseTime"] as! String)
                    MainWeather.currentTemp = data["obsrValue"] as! String
                    break
                }
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTemp"), object: nil)
            }
        }

        task.resume()
    }

    
    
    // API 2 : 동네예보 -> 최저/최고 기온
    static let villageBase = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?"
    static let villageType = "&pageNo=1&numOfRows=50&dataType=json"
    
    static func villageTimeString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let dateString: String
        let timeString: String
        
        // 0:00 ~ 2:10 -> 전날 23:59
        if (components.hour! < 2) || (components.hour == 2 && components.minute! <= 10) {
            timeString = "2359"
            dateString = dateFormatter.string(from: date-86400)
        }
        // 2:11 ~ 23:59 -> 그날 2:11
        else {
            timeString = "0211"
            dateString = dateFormatter.string(from: date)
        }
        
        return "&base_date="+dateString+"&base_time="+timeString
    }
    
    static func villageUrl(lat: CLLocationDegrees, lon: CLLocationDegrees) -> URL{
        return URL(string: self.villageBase+self.apiKey+self.villageType+self.villageTimeString()+self.coorString(lat: lat, lon: lon))!
    }
    
    static func getVillageTemp(){
        let url = self.villageUrl(lat: Place.lat, lon: Place.lon)
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
            guard let data = data else { return }
            print(data)
            
            let decoder = JSONDecoder()
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                else {
                    print("json error")
                    return
                }
            
            let resp = jsonData["response"] as! [String:Any]
            let hdr = resp["header"] as! [String:Any]
            let rslt = hdr["resultCode"] as! String
            
            if rslt != "00" {
                print("result code error")
                return
            }
            
            let bd = resp["body"] as! [String:Any]
            let items = bd["items"] as! [String:Any]
            let item = items["item"] as! [[String:Any]]
            
            var cnt = 0
            for i in item {
                let data = i as [String:Any]
                
                let cat = data["category"] as! String
                let fcstT = data["fcstTime"] as! String
                
                // 최저기온
                if cat == "TMN" && fcstT == "0600" {
                    MainWeather.minTemp = data["fcstValue"] as! String
                    cnt+=1
                }
                
                // 최고기온
                if cat == "TMX" && fcstT == "1500"{
                    MainWeather.maxTemp = data["fcstValue"] as! String
                    cnt+=1
                }
                
                if cnt==2 {
                    break
                }
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "VillageTemp"), object: nil)
            }
        }

        task.resume()
    }
    
}
