//
//  CodinationViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import UIKit


extension MainViewController {

    @objc func setCodiImage() {
        var codiName = String(Codination.level)+Codination.gender+"_"

        // 0~9 중 랜덤 세 개
        var numArray: [Int] = Array(0...9)
        numArray.shuffle()
        var codi1Name = codiName + String(numArray[0])
        var codi2Name = codiName + String(numArray[1])
        var codi3Name = codiName + String(numArray[2])

        // Reference to an image file in Firebase Storage
        var ref1 = CodinationClient.clothesRef.child("\(codi1Name).jpg")
        var ref2 = CodinationClient.clothesRef.child("\(codi2Name).jpg")
        var ref3 = CodinationClient.clothesRef.child("\(codi3Name).jpg")

        print(ref1)
        print(ref2)
        print(ref3)
        
        

        // Load the image using SDWebImage
        self.codi1Image.sd_setImage(with: ref1)
        if self.codi1Image.image == nil {
            ref1 = CodinationClient.clothesRef.child("\(codi1Name).JPG")
            self.codi1Image.sd_setImage(with: ref1)
        }
        self.codi2Image.sd_setImage(with: ref2)
        if self.codi2Image.image == nil {
            ref2 = CodinationClient.clothesRef.child("\(codi2Name).JPG")
            self.codi2Image.sd_setImage(with: ref2)
        }
        self.codi3Image.sd_setImage(with: ref3)
        if self.codi3Image.image == nil {
            ref3 = CodinationClient.clothesRef.child("\(codi3Name).JPG")
            self.codi3Image.sd_setImage(with: ref3)
        }

        self.view.layoutIfNeeded()
    }
}
