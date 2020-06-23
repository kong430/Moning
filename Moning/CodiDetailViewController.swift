//
//  CodiDetailViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/06/23.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class CodiDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var codiLargeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var text = ""
        
        switch Codination.level {
        case 0:
            text = "최고 기온 28도가 넘어가는 무더운 날입니다. 얇은 옷을 추천해요!\n"
        case 1:
            text = "더워요"
        case 2:
            text = "따뜻한 날씨입니다. 그러나 아직 반팔은 추울 수 있어요!\n"
        case 3:
            text = "밤엔 좀 쌀쌀함"
        case 4:
            text = "꽤 추움"
        case 5:
            text = "추워"
        case 6:
            text = "더추워"
        case 7:
            text = "더더추워"
  
        default:
            text = "이거 나오면 안 돼요 ㅠㅠ"
        }
        
        if Codination.windFlag {
            text += "바람이 많이 불어요. "
        }
        if Codination.rainFlag {
            text += "비가 와요. "
        }
        if Codination.coldHumidityFlag {
            text += "추운 데다가 습도까지 높아요. "
        }
        if Codination.windFlag || Codination.rainFlag || Codination.coldHumidityFlag {
            text += "더 춥게 느껴질 수 있으니 평소보다 두꺼운 옷을 추천드려요!\n"
        }
        
        if Codination.hotHumidityFlag {
            text += "더운 데다가 습도까지 높아 더 덥게 느껴질 거예요. \n"
        }
        
        if Codination.tempDiffFlag {
            text += "일교차가 커요! 가볍게 걸칠 수 있는 겉옷을 준비해 주세요.\n"
        }
        
        descriptionText.text = text + "\n 테스트 문구: 밑에 사진 이름은 \(Codination.tappedCodiName) "
        
        
        var ref = CodinationClient.clothesRef.child("\(Codination.tappedCodiName).jpg")
        ref.downloadURL { url, error in
            if let error = error {
                ref = CodinationClient.clothesRef.child("\(Codination.tappedCodiName).JPG")
                ref.downloadURL { url, error in
                    if let error = error {
                        print("ref: ", error)
                    }
                    else {
                        self.codiLargeImage.sd_setImage(with: ref)
                    }
                }
            }
            else {
                self.codiLargeImage.sd_setImage(with: ref)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableShoppingWeb), name: NSNotification.Name(rawValue: "Shopping"), object: nil)
        
    }
    
    @objc func enableShoppingWeb(){
        // 코디 이미지 클릭 이벤트
        codiLargeImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showShoppingWeb))
        codiLargeImage.addGestureRecognizer(tap)
    }
    
    @objc func showShoppingWeb(sender: UITapGestureRecognizer) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "webVCID")
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName!, animated: true, completion: nil)
        
    }
    
}
