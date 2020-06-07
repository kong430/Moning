//
//  MainViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/16.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import CoreLocation


class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        locationManager.startUpdatingLocation()
        self.getCurrentLocation()
    }

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        DispatchQueue.main.async {
            self.getCurrentLocation()
        }
    }
    
    // UI 띄우기
//    func update(){
//        nameLabel.text = Place.name
//        timeLabel.text = MainWeather.timeStamp
//        currentTempLabel.text = MainWeather.currentTemp
//        lowTempLabel.text = MainWeather.minTemp
//        highTempLabel.text = MainWeather.maxTemp
//        weatherImage.image = UIImage(named: MainWeather.icon+".png")
//        weatherLabel.text = MainWeather.description
//        self.view.layoutIfNeeded()
//    }

    func update1(){
        nameLabel.text = Place.name
        weatherImage.image = UIImage(named: MainWeather.icon+".png")
        weatherLabel.text = MainWeather.description
        self.view.layoutIfNeeded()
    }
    func update2(){
        lowTempLabel.text = MainWeather.minTemp + "℃"
        highTempLabel.text = MainWeather.maxTemp + "℃"
        self.view.layoutIfNeeded()
    }
    func update3(){
        timeLabel.text = MainWeather.timeStamp + " 기준"
        currentTempLabel.text = MainWeather.currentTemp + " ℃"
        self.view.layoutIfNeeded()
    }
    
    
    // 현위치 받아오기
    func getCurrentLocation(){
        var coor = locationManager.location?.coordinate
        
        if(coor==nil){
            print("error: location coordinate nil")
            return
        }
        
        Place.lat = coor?.latitude
        Place.lon = coor?.longitude
                
//        print(Place.lat)
//        print(Place.lon)

        let findLocation: CLLocation = CLLocation(latitude: coor!.latitude, longitude: coor!.longitude)
                let geoCoder: CLGeocoder = CLGeocoder()
                let local: Locale = Locale(identifier: "Ko-kr") // Korea
                geoCoder.reverseGeocodeLocation(findLocation, preferredLocale: local) { (place, error) in
                    if let address: [CLPlacemark] = place {
                        Place.name = String((address.last?.administrativeArea)!)+" "+String((address.last?.locality)!)+" "+String((address.last?.thoroughfare)!)
                        print(Place.name)
                    }
                }
        
        DispatchQueue.main.async {
            self.getWeather()
            self.getVillageTemp()
            self.getCurrentTemp()
        }
    }
    
    
    // openweather API
    var currentResult: CurrentResults?
    
    func getWeather(){
        let url = OpenWeatherClient.currentUrl(lat: Place.lat, lon: Place.lon)
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
    
            let decoder = JSONDecoder()
            if let searchData = try? decoder.decode(CurrentResults.self, from: data) {
                self.currentResult = searchData
                print(self.currentResult)
                
                // 날씨
                for weather in self.currentResult!.weather {
                    MainWeather.description = weather.description
                    MainWeather.icon = weather.icon
                }
                // 습도, 바람
                MainWeather.humidity = self.currentResult!.main.humidity
                MainWeather.windSpeed = self.currentResult!.wind.speed
            }

            DispatchQueue.main.async {
                self.update1()
            }
        }
        
        task.resume()
    }
    
    
    // 기상청 API 동네예보
    func getVillageTemp(){
        let url = KMAweatherClient.villageUrl(lat: Place.lat, lon: Place.lon)
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
                self.update2()
            }
        }

        task.resume()
    }
    
    // 기상청 API 초단기실황
    func getCurrentTemp(){
        let url = KMAweatherClient.nowcastUrl(lat: Place.lat, lon: Place.lon)
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
                self.update3()
            }
        }

        task.resume()
    }
    
    
    
    
}
