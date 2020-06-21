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
    static func description() -> String! { // 날씨 설명
        if icon == nil {
            return ""
        }
        let index = icon.index(icon.startIndex, offsetBy: 2)
        return weatherDescription[icon.substring(to: index)]
    }
    static var icon: String! = ""
    
    static var humidity: Int! // 습도
    static var windSpeed: Double! // 바람 속도
    static var feels_like: Double! // 체감온도
    
    // 기상청
    static var timeStamp: String! // 기준 시간
    static var currentTemp: String! // 현재기온
    static var minTemp: String! // 최저기온
    static var maxTemp: String! // 최고기온
    static var rainProb06: String! = "0" // 6시 강수확률
    static var rainProb09: String! = "0" // 9시 강수확률
    static var rainProb12: String! = "0" // 12시 강수확률
    static var rainProb15: String! = "0" // 15시 강수확률
    static var rainProb18: String! = "0" // 18시 강수확률
    static var rainProb21: String! = "0" // 21시 강수확률
    
    // 미세먼지
    static var pm10Val: String! // pm10 미세먼지
    static var pm25Val: String! // pm2.5 초미세먼지
    
    // 생활지수
    static var UVlight: String! // 자외선
    static var discomfort: String! // 불쾌지수
}

let weatherDescription = ["01":"맑음", "02":"약간 흐림", "03":"흐림", "04":"매우 흐림", "09":"소나기", "10":"비", "11":"뇌우", "13":"눈", "50":"안개"]
// clear sky, few clouds, scattered clouds, broken clouds, shower rain, rain, thunderstorm, snow, mist

