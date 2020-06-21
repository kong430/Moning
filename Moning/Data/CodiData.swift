//
//  CodiData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class Codination {
    
    static var windFlag = false
    static var hotHumidityFlag = false
    static var coldHumidityFlag = false
    static var tempDiffFlag = false
    
    static var level = -1
    
    static var gender = "g" // g면 여자(디폴트), b면 남자
    
    static func setLevel() {
        // 기온 분류
        var baseTemp = Double(MainWeather.maxTemp)!
        if baseTemp <= 5.0 {
            baseTemp = Double(MainWeather.minTemp)!
        }
        if 28.0 <= baseTemp {
            level = 0
        }
        else if 23.0 <= baseTemp && baseTemp < 28.0 {
            level = 1
        }
        else if 20.0 <= baseTemp && baseTemp < 23.0 {
            level = 2
        }
        else if 17.0 <= baseTemp && baseTemp < 20.0 {
            level = 3
        }
        else if 12.0 <= baseTemp && baseTemp < 17.0 {
            level = 4
        }
        else if 9.0 <= baseTemp && baseTemp < 12.0 {
            level = 5
        }
        else if 5.0 <= baseTemp && baseTemp < 9.0 {
            level = 6
        }
        else if baseTemp < 5.0 {
            level = 7
        }
        
        // 바람
        if baseTemp < 12.0 && MainWeather.windSpeed >= 8.0 {
            // 춥고 바람 많이 불면 두꺼운 옷
            level += 1
            windFlag = true
        }
        
        // 습도
        if baseTemp >= 23.0 && MainWeather.humidity >= 60 {
            // 덥고 습도 높으면 얇은 옷
            level -= 1
            hotHumidityFlag = true
        }
        else if baseTemp <= 8.0 && MainWeather.humidity >= 80 {
            // 춥고 습도 높으면 두꺼운 옷
            level += 1
            coldHumidityFlag = true
        }
        
        // 일교차
        var tempDiff = Double(MainWeather.maxTemp)! - Double(MainWeather.minTemp)!
        if tempDiff >= 12.0 {
            // 일교차 크면 겉옷 필요
            tempDiffFlag = true
        }
        
        DispatchQueue.main.async {
            // 옷 요청하기
        }
    }
    
    static var codiImages = ["01d.png","02d.png","03d.png"]
}
