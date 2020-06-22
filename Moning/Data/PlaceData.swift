//
//  PlaceData.swift
//  Moning
//
//  Created by 이제인 on 2020/05/25.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import CoreLocation

class Place {
    static var name: String! // 주소
    static var lat: CLLocationDegrees! // 위도
    static var lon: CLLocationDegrees! // 경도
    static var nx: Int! // 기상청 x좌표
    static var ny: Int! // 기상청 y좌표
    
    static var sidoName: String! // 시도 이름
    static var cityName: String! // 구역 이름
    
    // 미세먼지
    static func sidoUrl() -> String {
        if sidoName == nil {
            return ""
        }
        return sidoList[sidoName]!
    }
    
    // 자외선
    static func codeUrl() -> String {
        if sidoName == nil {
            return ""
        }
        return sidoCode[sidoName]!
    }
    
}


// 서울, 부산, 대구, 인천, 광주, 대전, 울산, 경기, 강원, 충북, 충남, 전북, 전남, 경북, 경남, 제주, 세종
let sidoList = ["서울특별시":"%EC%84%9C%EC%9A%B8", "부산광역시":"%EB%B6%80%EC%82%B0", "대구광역시":"%EB%8C%80%EA%B5%AC", "인천광역시":"%EC%9D%B8%EC%B2%9C", "광주광역시":"%EA%B4%91%EC%A3%BC", "대전광역시":"%EB%8C%80%EC%A0%84", "울산광역시":"%EC%9A%B8%EC%82%B0", "경기도":"%EA%B2%BD%EA%B8%B0", "강원도":"%EA%B0%95%EC%9B%90", "충청북도":"%EC%B6%A9%EB%B6%81", "충청남도":"%EC%B6%A9%EB%82%A8", "전라북도":"%EC%A0%84%EB%B6%81", "전라남도":"%EC%A0%84%EB%82%A8", "경상북도":"%EA%B2%BD%EB%B6%81", "경상남도":"%EA%B2%BD%EB%82%A8", "제주도":"%EC%A0%9C%EC%A3%BC", "세종특별자치시":"%EC%84%B8%EC%A2%85"]

let sidoCode = ["서울특별시":"1100000000", "부산광역시":"2600000000", "대구광역시":"2700000000", "인천광역시":"2800000000", "광주광역시":"2900000000", "대전광역시":"3000000000", "울산광역시":"3100000000", "경기도":"4100000000", "강원도":"4200000000", "충청북도":"4300000000", "충청남도":"4400000000", "전라북도":"4500000000", "전라남도":"4600000000", "경상북도":"4700000000", "경상남도":"4800000000", "제주도":"5000000000", "세종특별자치시":"3600000000"]


