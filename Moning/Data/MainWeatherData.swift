//
//  MainWeatherData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class MainWeather {
    
    // open weather
    static var description: String! // 날씨 설명
    static var icon: String! = ""
    
    static var humidity: Int! // 습도
    static var windSpeed: Double! // 바람 속도
    static var feels_like: Double! // 체감온도
    
    // 기상청 동네예보
    static var timeStamp: String!
    static var currentTemp: String! // Double
    static var minTemp: String! // Double
    static var maxTemp: String! // Double
    
    // 강수량
    
    // 미세먼지
    static var pm10Val: String! // pm10 미세먼지
    static var pm25Val: String! // pm2.5 초미세먼지
    
    // 생활지수
    static var UVlight: String! // 자외선
    static var discomfort: String! // 불쾌지수
}
