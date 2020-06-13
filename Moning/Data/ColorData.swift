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
        return UIColor(displayP3Red: 170, green: 228, blue: 254, alpha: 1)
    case "02d":
        return UIColor(displayP3Red: 188, green: 236, blue: 254, alpha: 1)
    case "03d":
        return UIColor(displayP3Red: 153, green: 214, blue: 253, alpha: 1)
    case "04d":
        return UIColor(displayP3Red: 214, green: 236, blue: 244, alpha: 1)
    case "09d":
        return UIColor(displayP3Red: 140, green: 157, blue: 195, alpha: 1)
    case "10d":
        return UIColor(displayP3Red: 188, green: 183, blue: 253, alpha: 1)
    case "11d":
        return UIColor(displayP3Red: 100, green: 108, blue: 134, alpha: 1)
    case "13d":
        return UIColor(displayP3Red: 237, green: 250, blue: 255, alpha: 1)
    case "50d":
        return UIColor(displayP3Red: 245, green: 245, blue: 245, alpha: 1)
                
    case "01n":
        return UIColor(displayP3Red: 65, green: 113, blue: 144, alpha: 1)
    case "02n":
        return UIColor(displayP3Red: 79, green: 120, blue: 147, alpha: 1)
    case "03n":
        return UIColor(displayP3Red: 86, green: 121, blue: 144, alpha: 1)
    case "04n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    case "09n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    case "10n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    case "11n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    case "13n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    case "50n":
        return UIColor(displayP3Red: 94, green: 94, blue: 94, alpha: 1)
    
    default:
        return UIColor.white
    }
}
