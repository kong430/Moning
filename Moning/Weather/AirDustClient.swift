//
//  AirDustClient.swift
//  Moning
//
//  Created by 이제인 on 2020/06/08.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import CoreLocation

class AirDustClient {
    
    static let airBase = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureSidoLIst?"
    
    static let apiKey = "&ServiceKey=bUUAThKo0ONn9UfQ2I5%2FkOt5ZYqr4JLrZyPBIV3ZNvR%2FNsJB4PTpDuNM%2FlN1g8jH3ITlWNy24RnCzjYjk7paVg%3D%3D"
    
    static let airSidoName = "&sidoName=" + Place.sidoUrl()
    
    static let airType = "&searchCondition=DAILY&pageNo=1&numOfRows=30&_returnType=json"
    
    static func airUrl() -> URL{
        return URL(string: self.airBase+self.apiKey+self.airSidoName+self.airType)!
    }
    
    static func getAirDust(){
        let url = self.airUrl()
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
            guard let data = data else { return }
            print(data)
        
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AirDust"), object: nil)
            }
        }

        task.resume()
    }
}
