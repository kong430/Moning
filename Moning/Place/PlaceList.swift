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
    //init(place: String, location: String){
    init(place: String, location: String, latitude: Double, longitude: Double){
        self.place = place
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
    }
}
