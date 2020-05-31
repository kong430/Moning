//
//  CurrentWeatherData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class CurrentWeather {
    static var description: String! // 날씨 설명
    static var icon: String! // 이미지
    
    static var temp: Double!
    static var temp_min: Double!
    static var temp_max: Double!
    
    static var humidity: Int!
    static var feels_like: Double!
    static var wind_speed: Double! // 바람 속도
    static var clouds: Int! // 구름 정도 (%)
}
