//
//  SecondViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/17.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dust10Label: UILabel!
    @IBOutlet weak var dust25Label: UILabel!
    @IBOutlet weak var dust10Image: UIImageView!
    @IBOutlet weak var dust25Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async{
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
        }
    }
    
    @objc func updateAirDust(){
        self.view.backgroundColor = getBackgroundColor(icon: MainWeather.icon)
        
        dust10Label.text = MainWeather.pm10Val
        dust25Label.text = MainWeather.pm25Val
        
        // 초미세먼지
        if MainWeather.pm25Val == "" {
            dust25Image.tintColor = UIColor.systemGray2
        }
        else{
            //  0~15 / 16~35 / 36~75 / 76~
            let dust25 = Int(MainWeather.pm25Val)!
            if 0 <= dust25 && dust25 <= 15 {
                dust25Image.tintColor = UIColor.systemBlue
            }
            else if 16 <= dust25 && dust25 <= 35 {
                dust25Image.tintColor = UIColor.systemGreen
            }
            else if 36 <= dust25 && dust25 <= 75 {
                dust25Image.tintColor = UIColor.systemYellow
            }
            else if 76 <= dust25 {
                dust25Image.tintColor = UIColor.systemRed
            }
        }
        
        // 미세먼지
        if MainWeather.pm10Val == "" {
            dust10Image.tintColor = UIColor.systemGray2
        }
        else {
            //  0~30 / 31~80 / 81~150 / 151~
            let dust10 = Int(MainWeather.pm10Val)!
            if 0 <= dust10 && dust10 <= 30 {
                dust10Image.tintColor = UIColor.systemBlue
            }
            else if 31 <= dust10 && dust10 <= 80 {
                dust10Image.tintColor = UIColor.systemGreen
            }
            else if 81 <= dust10 && dust10 <= 150 {
                dust10Image.tintColor = UIColor.systemYellow
            }
            else if 151 <= dust10 {
                dust10Image.tintColor = UIColor.systemRed
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
}
