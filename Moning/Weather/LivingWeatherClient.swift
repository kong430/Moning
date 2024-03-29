//
//  LivingWeatherClient.swift
//  Moning
//
//  Created by 이제인 on 2020/06/20.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class LivingWeatherClient {
    
    static let livingBase = "http://apis.data.go.kr/1360000/LivingWthrIdxService"
    static let apiKey = "?serviceKey=bUUAThKo0ONn9UfQ2I5%2FkOt5ZYqr4JLrZyPBIV3ZNvR%2FNsJB4PTpDuNM%2FlN1g8jH3ITlWNy24RnCzjYjk7paVg%3D%3D"
    static let livingType = "&numOfRows=50&pageNo=1&dataType=json"
    
    static func livingAreaNo() -> String {
        return "&areaNo=" + Place.codeUrl()
    }
    
    static func livingTimeString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHH"
        
        return "&time="+dateFormatter.string(from: date)
    }
    
    // 자외선 지수

    /*
    static var UVItemType: String!
    
    static func UVTimeString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let dateString: String
        let timeString: String

        // 00:00~07:10 : 전 날 18시에 tomorrow 받아오기
        if (components.hour! <= 6) || (components.hour == 7 && components.minute! <= 10) {
            timeString = "18"
            dateString = dateFormatter.string(from: date-86400)
            self.UVItemType = "tomorrow"
        }
        // 07:11~23:59 : 그 날 06시에 today 받아오기
        else {
            timeString = "06"
            dateString = dateFormatter.string(from: date)
            self.UVItemType = "today"
        }
        
        return "&time="+dateString+timeString
    }*/
    
    
    static func UVUrl() -> URL{
        return URL(string: self.livingBase+"/getUVIdx"+self.apiKey+self.livingType+self.livingAreaNo()+self.livingTimeString())!
    }
    
    static func getUV(){
        let url = self.UVUrl()
//        print(url)
            
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
                
            let decoder = JSONDecoder()
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                else {
                    print("UV: json error")
                    return
                }
                
            let resp = jsonData["response"] as! [String:Any]
            let hdr = resp["header"] as! [String:Any]
            let rslt = hdr["resultCode"] as! String
            
            if rslt != "00" {
                print("UV: result code error")
                return
            }
            
            let bd = resp["body"] as! [String:Any]
            let items = bd["items"] as! [String:Any]
            let item = items["item"] as! [[String:Any]]
        
            for i in item {
                let data = i as [String:Any]

                var UVResult = data["today"] as! String
                if UVResult == "" {
                    UVResult = data["tomorrow"] as! String
                }
                MainWeather.UVlight = UVResult
                
                var UVnum = Int(MainWeather.UVlight)!
                
                if 0 <= UVnum && UVnum <= 2 {
                    MainWeather.UVlightState = "낮음"
                    MainWeather.UVlightImage = "uv1.png"
                }
                else if 3 <= UVnum && UVnum <= 5 {
                    MainWeather.UVlightState = "보통"
                    MainWeather.UVlightImage = "uv2.png"
                }
                else if 6 <= UVnum && UVnum <= 7 {
                    MainWeather.UVlightState = "높음"
                    MainWeather.UVlightImage = "uv3.png"
                }
                else if 8 <= UVnum && UVnum <= 10 {
                    MainWeather.UVlightState = "매우 높음"
                    MainWeather.UVlightImage = "uv4.png"
                }
                else if 11 <= UVnum {
                    MainWeather.UVlightState = "위험"
                    MainWeather.UVlightImage = "uv5.png"
                }
                
                print("UV: success")
            }
            
            if MainWeather.UVlight == "" {
                print("UV: fail")
            }
            
            
            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UV"), object: "nil")
                LivingWeatherClient.getDiscomfort()
            }
        }
        task.resume()
    }
    
    
    // 불쾌지수 : 6월~9월만 나옴
    
    static func discomfortUrl() -> URL{
        return URL(string: self.livingBase+"/getDiscomfortIdx"+self.apiKey+self.livingType+self.livingAreaNo()+self.livingTimeString())!
    }
        
    static func getDiscomfort(){
        let url = self.discomfortUrl()
//        print(url)
            
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
                
            let decoder = JSONDecoder()
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                else {
                    print("UV: json error")
                    return
                }
                
            let resp = jsonData["response"] as! [String:Any]
            let hdr = resp["header"] as! [String:Any]
            let rslt = hdr["resultCode"] as! String
            
            if rslt != "00" {
                print("discomfort: result code error")
                MainWeather.discomfort = ""
                return
            }
            
            let bd = resp["body"] as! [String:Any]
            let items = bd["items"] as! [String:Any]
            let item = items["item"] as! [[String:Any]]
        
            for i in item {
                let data = i as [String:Any]

                var discomfortResult = data["h3"] as! String
                MainWeather.discomfort = discomfortResult
                
                var discomfortNum = Int(MainWeather.discomfort)!
                
                if discomfortNum < 68 {
                    MainWeather.discomfortState = "낮음: 전원 쾌적함을 느낌"
                    MainWeather.discomfortImage = "discomfort1.png"
                }
                else if 68 <= discomfortNum && discomfortNum < 75 {
                    MainWeather.discomfortState = "보통: 불쾌감을 느끼기 시작함"
                    MainWeather.discomfortImage = "discomfort2.png"
                }
                else if 75 <= discomfortNum && discomfortNum < 80 {
                    MainWeather.discomfortState = "높음: 50% 정도 불쾌감을 느낌"
                    MainWeather.discomfortImage = "discomfort3.png"
                }
                else if 80 <= discomfortNum {
                    MainWeather.discomfortState = "매우 높음: 전원 불쾌감을 느낌"
                    MainWeather.discomfortImage = "discomfort4.png"
                }
                
                print("discomfort: success")
            }
            
            if MainWeather.discomfort == "" {
                print("discomfort: fail")
            }
            
            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "discomfort"), object: "nil")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fin"), object: "nil")
            }
        }
        task.resume()
    }
    
    
}
