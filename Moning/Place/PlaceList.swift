//
//  PlaceList.swift
//  Moning
//
//  Created by Park MinGyeong on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

struct PlaceList {
    var place: String = ""
    var location: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    var sidoName_: String = ""
    var cityName_: String = ""
    //init(place: String, location: String){
    init(place: String, location: String, latitude: Double, longitude: Double, sido: String, city: String){
        self.place = place
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.sidoName_ = sido
        self.cityName_ = city
    }
}
