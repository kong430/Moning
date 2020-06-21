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
    
    @IBOutlet weak var notifyTitleLabel: UILabel!
    @IBOutlet weak var codiTitleLabel: UILabel!
    
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        locationManager.startUpdatingLocation()
        self.getCurrentLocation()
    }

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeather), name: NSNotification.Name(rawValue: "Weather"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateVillageTemp), name: NSNotification.Name(rawValue: "VillageTemp"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentTemp), name: NSNotification.Name(rawValue: "CurrentTemp"), object: nil)
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

    @objc func updateWeather(){
        nameLabel.text = Place.name
        weatherImage.image = UIImage(named: MainWeather.icon+".png")
        weatherLabel.text = MainWeather.description
        
        updateColor()
        
        self.view.layoutIfNeeded()
    }
    
    func updateColor() {
        self.view.backgroundColor = getBackgroundColor(icon: MainWeather.icon)
        
        nameLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        timeLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        currentTempLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        lowTempLabel.textColor = getBlueColor(icon: MainWeather.icon)
        highTempLabel.textColor = getRedColor(icon: MainWeather.icon)
        weatherLabel.textColor = getMainTextColor(icon: MainWeather.icon)
    
        notifyTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        codiTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
    }
    
    @objc func updateVillageTemp(){
        lowTempLabel.text = MainWeather.minTemp
        highTempLabel.text = MainWeather.maxTemp
        
        self.view.layoutIfNeeded()
    }
    
    @objc func updateCurrentTemp(){
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
                print(address)
                Place.sidoName = String((address.last?.administrativeArea)!)
                Place.cityName = String((address.last?.locality)!)
                
                let sub: String!
                if (address.last?.subLocality != nil) {
                    sub = String((address.last?.subLocality)!)
                }
                else {
                    sub = String((address.last?.thoroughfare)!)
                }
                
                if (Place.sidoName == "세종특별자치시") { // 세종시 예외처리
                    Place.cityName = "세종시"
                    Place.name = Place.sidoName + " " + sub
                }
                else {
                    Place.name = Place.sidoName + " " + Place.cityName + " " + sub
                }
                print(Place.name)
            }
            
            DispatchQueue.main.async {
                self.getWeather()
            }
        }

    }
    
    
    // openweather API
    var currentResult: CurrentResults?
    
    func getWeather(){
        let url = OpenWeatherClient.currentUrl(lat: Place.lat, lon: Place.lon)
//        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
    
            let decoder = JSONDecoder()
            if let searchData = try? decoder.decode(CurrentResults.self, from: data) {
                self.currentResult = searchData
//                print(self.currentResult)
                
                // 날씨
                for weather in self.currentResult!.weather {
                    MainWeather.description = weather.description
                    MainWeather.icon = weather.icon
                }
                // 습도, 바람, 체감기온
                MainWeather.humidity = self.currentResult!.main.humidity
                MainWeather.windSpeed = self.currentResult!.wind.speed
                MainWeather.feels_like = self.currentResult!.main.feels_like - 273.15 // 캘빈 -> 섭씨
            }
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Weather"), object: nil)
                KMAweatherClient.getVillageTemp()
                KMAweatherClient.getCurrentTemp()
                AirDustClient.getAirDust()
                LivingWeatherClient.getUV()
                LivingWeatherClient.getDiscomfort()
            }
        }
        
        task.resume()
    }
    
    
        
    
    
    
}
