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
        var nameKor: String
        var flag: Bool
        var text: String
    }
    
    static var notifyModels = [
        notifyModel(name: "handheld", nameKor: "손풍기", flag: false, text: ""),
        notifyModel(name: "hotpack", nameKor: "핫팩", flag: false, text: ""),
        notifyModel(name: "scarf", nameKor: "목도리", flag: false, text: ""),
        notifyModel(name: "mask", nameKor: "마스크", flag: false, text: ""),
        notifyModel(name: "sunglasses", nameKor: "선글라스", flag: false, text: ""),
        notifyModel(name: "sunscreen", nameKor: "선크림" , flag: false, text: ""),
        notifyModel(name: "umbrella", nameKor: "우산", flag: false, text: "")
    ]
    
    static var specialModel = notifyModel(name: "perfect", nameKor: "완벽한 날씨!", flag: false, text: "준비물이 필요없는 완벽한 하루 보내세요🤗")
    
    static var needNotify: [notifyModel] = []
    
    
    
}
