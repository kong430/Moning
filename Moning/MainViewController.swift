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
    
    func update(){
        nameLabel.text = Place.name
        currentTempLabel.text = String(CurrentWeather.temp)
        lowTempLabel.text = String(CurrentWeather.temp_min)
        highTempLabel.text = String(CurrentWeather.temp_max)
        weatherImage.image = UIImage(named: CurrentWeather.icon+".png")
        weatherLabel.text = CurrentWeather.description
        self.view.layoutIfNeeded()
    }
    
    
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
        }
    }
    
    var currentResult: CurrentResults?
    
    func getWeather(){
        let url = OpenWeatherClient.currentUrl(lat: Place.lat, lon: Place.lon)
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            print(data)
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            if let searchData = try? decoder.decode(CurrentResults.self, from: data) {
                self.currentResult = searchData
                
                print(self.currentResult)
                
                for weather in self.currentResult!.weather {
                    CurrentWeather.description = weather.description
                    CurrentWeather.icon = weather.icon
                }
                
                CurrentWeather.temp = self.currentResult!.main.temp
                CurrentWeather.temp_min = self.currentResult!.main.temp_min
                CurrentWeather.temp_max = self.currentResult!.main.temp_max
                
                CurrentWeather.humidity = self.currentResult!.main.humidity
                CurrentWeather.feels_like = self.currentResult!.main.feels_like
                CurrentWeather.wind_speed = self.currentResult!.wind.speed
                CurrentWeather.clouds = self.currentResult!.clouds.all
                
            }

            DispatchQueue.main.async {
                self.update()
            }
        }
        
        task.resume()
    }
    
}
