//
//  NotifyData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation

class NotifyThings {
    
    struct notifyModel {
        var name: String
        var flag: Bool
        var text: String
    }
    
    static var notifyModels = [
        notifyModel(name: "handheld", flag: false, text: ""),
        notifyModel(name: "hotpack", flag: false, text: ""),
        notifyModel(name: "scarf", flag: false, text: ""),
        notifyModel(name: "mask", flag: false, text: ""),
        notifyModel(name: "sunglasses", flag: false, text: ""),
        notifyModel(name: "sunscreen", flag: false, text: ""),
        notifyModel(name: "umbrella", flag: false, text: "")
    ]
    
    static var specialModel = notifyModel(name: "perfect", flag: false, text: "준비물이 필요없는 완벽한 날씨!")
    
    static var needNotify: [notifyModel] = []
    
    
    
}
