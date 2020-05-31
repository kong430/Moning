//
//  OpenWeatherClient.swift
//  Moning
//
//  Created by 이제인 on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import CoreLocation

class OpenWeatherClient {

    
    // API call: api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
    
    static let currentBase = "http://api.openweathermap.org/data/2.5/weather?"
    static let forcastBase = "http://api.openweathermap.org/data/2.5/forecast?"
    
    static let apiKey = "&appid=ea5b901b2965ba485d4dfb7d16e3c357"
    
//    static var coorString = "lat="+String(Place.lat)+"&lon="+String(Place.lon)
    
    static func coorString(lat: CLLocationDegrees, lon: CLLocationDegrees) -> String {
        return "lat="+String(lat)+"&lon="+String(lon)
    }
    
    static func currentUrl(lat: CLLocationDegrees, lon: CLLocationDegrees) -> URL{
        return URL(string: self.currentBase+self.coorString(lat: lat, lon: lon)+self.apiKey)!
    }
}
