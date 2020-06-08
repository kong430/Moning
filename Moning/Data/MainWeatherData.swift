//
//  MainWeatherData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class MainWeather {
    
    static var description: String! // 날씨 설명
    static var icon: String! // 이미지
    
    static var timeStamp: String!
    static var currentTemp: String! // Double
    static var minTemp: String! // Double
    static var maxTemp: String! // Double
    
    static var humidity: Int! // 습도
    static var windSpeed: Double! // 바람 속도
    
    // 미세먼지
    // 자외선
    // 불쾌지수
    // 체감기온
}
