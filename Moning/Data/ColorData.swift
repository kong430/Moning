//
//  ColorData.swift
//  Moning
//
//  Created by 이제인 on 2020/06/13.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import UIKit


func getBackgroundColor(icon: String) -> UIColor {
    switch icon {
        
    case "01d":
        return UIColor(displayP3Red: 170/255, green: 228/255, blue: 254/255, alpha: 1)
    case "02d":
        return UIColor(displayP3Red: 188/255, green: 236/255, blue: 254/255, alpha: 1)
    case "03d":
        return UIColor(displayP3Red: 153/255, green: 214/255, blue: 253/255, alpha: 1)
    case "04d":
        return UIColor(displayP3Red: 214/255, green: 236/255, blue: 244/255, alpha: 1)
    case "09d":
        return UIColor(displayP3Red: 140/255, green: 157/255, blue: 195/255, alpha: 1)
    case "10d":
        return UIColor(displayP3Red: 188/255, green: 183/255, blue: 253/255, alpha: 1)
    case "11d":
        return UIColor(displayP3Red: 100/255, green: 108/255, blue: 134/255, alpha: 1)
    case "13d":
        return UIColor(displayP3Red: 237/255, green: 250/255, blue: 255/255, alpha: 1)
    case "50d":
        return UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                
    case "01n":
        return UIColor(displayP3Red: 65/255, green: 113/255, blue: 144/255, alpha: 1)
    case "02n":
        return UIColor(displayP3Red: 79/255, green: 120/255, blue: 147/255, alpha: 1)
    case "03n":
        return UIColor(displayP3Red: 86/255, green: 121/255, blue: 144/255, alpha: 1)
    case "04n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    case "09n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    case "10n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    case "11n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    case "13n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    case "50n":
        return UIColor(displayP3Red: 94/255, green: 94/255, blue: 94/255, alpha: 1)
    
    default:
        return UIColor.white
    }
}


func getMainTextColor(icon: String) -> UIColor {
    if icon != "" && (icon.hasSuffix("n") || icon == "11d") {
        return UIColor.white
    }
    else {
        return UIColor.black
    }
}

func getRedColor(icon: String) -> UIColor {
    if icon != "" && icon.hasSuffix("n") {
        return UIColor(displayP3Red: 255/255, green: 149/255, blue: 202/255, alpha: 1)
    }
    
    switch icon {
    case "01d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
    case "02d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
    case "03d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
    case "04d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
    case "09d":
        return UIColor(displayP3Red: 212/255, green: 24/255, blue: 118/255, alpha: 1)
    case "10d":
        return UIColor(displayP3Red: 212/255, green: 24/255, blue: 118/255, alpha: 1)
    case "11d":
        return UIColor(displayP3Red: 255/255, green: 149/255, blue: 202/255, alpha: 1)
    case "13d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
    case "50d":
        return UIColor(displayP3Red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
                
    default:
        return UIColor.red
    }
}


func getBlueColor(icon: String) -> UIColor {
    if icon != "" && icon.hasSuffix("n") {
        return UIColor(displayP3Red: 115/255, green: 253/255, blue: 234/255, alpha: 1)
    }
    
    switch icon {
    case "01d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "02d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "03d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "04d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "09d":
        return UIColor(displayP3Red: 115/255, green: 253/255, blue: 234/255, alpha: 1)
    case "10d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "11d":
        return UIColor(displayP3Red: 115/255, green: 253/255, blue: 234/255, alpha: 1)
    case "13d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
    case "50d":
        return UIColor(displayP3Red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
                
    default:
        return UIColor.blue
    }
}
