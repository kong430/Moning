//
//  CodinationClient.swift
//  Moning
//
//  Created by 이제인 on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import Firebase

class CodinationClient {
    
    // Get a reference to the storage service using the default Firebase App
    static let storage = Storage.storage()
    // Create a storage reference from our storage service
    static let storageRef = storage.reference()
    // Create a child reference
    static let clothesRef = storageRef.child("clothes")
    
//    static let gsRef = storage.reference(forURL: "gs://moning-967e3.appspot.com")
    
    
    static func setLevel() {
        // 기온 분류
        var baseTemp = Double(MainWeather.maxTemp)!
        if baseTemp <= 5.0 {
            baseTemp = Double(MainWeather.minTemp)!
        }
        
        if 28.0 <= baseTemp {
            Codination.level = 0
        }
        else if 23.0 <= baseTemp && baseTemp < 28.0 {
            Codination.level = 1
        }
        else if 20.0 <= baseTemp && baseTemp < 23.0 {
            Codination.level = 2
        }
        else if 17.0 <= baseTemp && baseTemp < 20.0 {
            Codination.level = 3
        }
        else if 12.0 <= baseTemp && baseTemp < 17.0 {
            Codination.level = 4
        }
        else if 9.0 <= baseTemp && baseTemp < 12.0 {
            Codination.level = 5
        }
        else if 5.0 <= baseTemp && baseTemp < 9.0 {
            Codination.level = 6
        }
        else if baseTemp < 5.0 {
            Codination.level = 7
        }

        // 바람
        if baseTemp < 12.0 && MainWeather.windSpeed >= 8.0 {
            // 춥고 바람 많이 불면 두꺼운 옷
            Codination.level += 1
            Codination.windFlag = true
        }

        // 습도
        if baseTemp >= 23.0 && MainWeather.humidity >= 60 {
            // 덥고 습도 높으면 얇은 옷
            Codination.level -= 1
            Codination.hotHumidityFlag = true
        }
        else if baseTemp <= 8.0 && MainWeather.humidity >= 80 {
            // 춥고 습도 높으면 두꺼운 옷
            Codination.level += 1
            Codination.coldHumidityFlag = true
        }

        // 일교차
        var tempDiff = Double(MainWeather.maxTemp)! - Double(MainWeather.minTemp)!
        if tempDiff >= 12.0 {
            // 일교차 크면 겉옷 필요
            Codination.tempDiffFlag = true
        }

        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "codi"), object: "nil")
        }
    }
}
