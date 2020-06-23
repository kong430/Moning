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
        
        ref1.downloadURL { url, error in
            if let error = error {
//                print("ref1: ", error)
                ref1 = CodinationClient.clothesRef.child("\(codi1Name).JPG")
                ref1.downloadURL { url, error in
                    if let error = error {
                        print("ref1: ", error)
                    }
                    else {
                        self.codi1Image.sd_setImage(with: ref1)
                    }
                }
            }
            else {
                self.codi1Image.sd_setImage(with: ref1)
            }
        }
        ref2.downloadURL { url, error in
            if let error = error {
//                print("ref2: ", error)
                ref2 = CodinationClient.clothesRef.child("\(codi2Name).JPG")
                ref2.downloadURL { url, error in
                    if let error = error {
                        print("ref2: ", error)
                    }
                    else {
                        self.codi2Image.sd_setImage(with: ref2)
                    }
                }
            }
            else {
                self.codi2Image.sd_setImage(with: ref2)
            }
        }
        ref3.downloadURL { url, error in
            if let error = error {
//                print("ref3: ", error)
                ref3 = CodinationClient.clothesRef.child("\(codi3Name).JPG")
                ref3.downloadURL { url, error in
                    if let error = error {
                        print("ref3: ", error)
                    }
                    else {
                        self.codi3Image.sd_setImage(with: ref3)
                    }
                }
            }
            else {
                self.codi3Image.sd_setImage(with: ref3)
            }
        }
        
        // 코디 이미지 클릭 이벤트
        codi1Image.isUserInteractionEnabled = true
        let tap1 = CodiTapGesture(target: self, action: #selector(codiImageTapped))
        tap1.tappedCodiName = codi1Name
        codi1Image.addGestureRecognizer(tap1)
        
        codi2Image.isUserInteractionEnabled = true
        let tap2 = CodiTapGesture(target: self, action: #selector(codiImageTapped))
        tap2.tappedCodiName = codi2Name
        codi2Image.addGestureRecognizer(tap2)
        
        codi3Image.isUserInteractionEnabled = true
        let tap3 = CodiTapGesture(target: self, action: #selector(codiImageTapped))
        tap3.tappedCodiName = codi3Name
        codi3Image.addGestureRecognizer(tap3)
    
        self.view.layoutIfNeeded()
    }
    
    
    // 코디 이미지 클릭 이벤트
    @objc func codiImageTapped(sender: CodiTapGesture){
        Codination.tappedCodiName = sender.tappedCodiName
        print("click!!!!!!!!!!", Codination.tappedCodiName)
        
        var linkRef = CodinationClient.storageRef.child("codiLink.json")
        linkRef.getData(maxSize: 1*1024*1024) { data, error in
            if let error = error {
                print("codiLink: getData error")
            }
            else {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    else {
                        print("codiLink: json error")
                        return
                }
                let resp = jsonData["response"] as! [[String:Any]]
                for i in resp {
                    let item = i as [String:Any]
                    
                    let name = item["name"] as! String
                    let url = item["url"] as! String
                    
                    if name == Codination.tappedCodiName {
                        Codination.tappedCodiUrl = url
                    }
                }
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Shopping"), object: "nil")
                }
            }
        }
        
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "detailVCID")
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
        
    }
}
