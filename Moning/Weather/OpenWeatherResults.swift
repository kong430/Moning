//
//  OpenWeatherResults.swift
//  Moning
//
//  Created by 이제인 on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

struct CurrentResults: Decodable, Equatable {
    let weather: [WeatherData]
    let main: MainData
    let wind: WindData
}

struct ForecastResults: Decodable, Equatable {
    let list: [FiveDay]
}


struct WeatherData: Codable, Equatable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Codable, Equatable {
    let temp: Double
    let humidity: Int
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
}

struct WindData: Codable, Equatable {
    let speed: Double
    let deg: Int
}

struct FiveDay: Codable, Equatable {
    let dt: Int
    let dt_txt: String
    let main: MainData
    let weather: [WeatherData]
    let wind: WindData
}
