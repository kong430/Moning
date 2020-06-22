//
//  SecondViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/17.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var dust10numLabel: UILabel!
    @IBOutlet weak var dust25numLabel: UILabel!
    @IBOutlet weak var dust10Image: UIImageView!
    @IBOutlet weak var dust25Image: UIImageView!
    @IBOutlet weak var dust10textLabel: UILabel!
    @IBOutlet weak var dust25textLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var uvImage: UIImageView!
    @IBOutlet weak var feellikeLabel: UILabel!
    @IBOutlet weak var discomfortLabel: UILabel!
    @IBOutlet weak var discomfortImage: UIImageView!
    
    @IBOutlet weak var dustTitleLabel: UILabel!
    @IBOutlet weak var dust10TitleLabel: UILabel!
    @IBOutlet weak var dust25TitleLabel: UILabel!
    @IBOutlet weak var dust10SubImage: UIImageView!
    @IBOutlet weak var dust25SubImage: UIImageView!
    
    @IBOutlet weak var detailWeatherTitleLabel: UILabel!
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var rainTitleLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var uvTitleLabel: UILabel!
    @IBOutlet weak var feellikeTitleLabel: UILabel!
    @IBOutlet weak var discomfortTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailWeather), name: NSNotification.Name(rawValue: "Weather"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUV), name: NSNotification.Name(rawValue: "UV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDiscomfort), name: NSNotification.Name(rawValue: "discomfort"), object: nil)
    }
    
    @objc func updateDetailWeather(){
        windLabel.text = String(MainWeather.windSpeed)+"m/s"
        humidityLabel.text = String(MainWeather.humidity)+"%"
        feellikeLabel.text = String(format: "%.1f", MainWeather.feels_like)+"℃"
        
        var rainProb = 0
        rainProb = max(rainProb, Int(MainWeather.rainProb06)!)
        rainProb = max(rainProb, Int(MainWeather.rainProb09)!)
        rainProb = max(rainProb, Int(MainWeather.rainProb12)!)
        rainProb = max(rainProb, Int(MainWeather.rainProb15)!)
        rainProb = max(rainProb, Int(MainWeather.rainProb18)!)
        rainProb = max(rainProb, Int(MainWeather.rainProb21)!)
        rainLabel.text = String(rainProb)+"%"
        
        self.updateColor()
        
        self.view.layoutIfNeeded()
    }
    
    func updateColor(){
        self.view.backgroundColor = getBackgroundColor(icon: MainWeather.icon)
        
        dust10SubImage.tintColor = getBackgroundColor(icon: MainWeather.icon)
        dust25SubImage.tintColor = getBackgroundColor(icon: MainWeather.icon)
        
        dustTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust10numLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust25numLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust10TitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust25TitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust10textLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        dust25textLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        
        detailWeatherTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        windTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        windLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        rainTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        rainLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        humidityTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        humidityLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        uvTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        uvLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        feellikeTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        feellikeLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        discomfortTitleLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        discomfortLabel.textColor = getMainTextColor(icon: MainWeather.icon)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func updateUV(){
        uvLabel.text = MainWeather.UVlight
        
        if MainWeather.UVlight == "" {
            uvImage.image = UIImage(named: "uv1"+".png")
        }
        else {
            var UVnum = Int(MainWeather.UVlight)!
            
            if 0 <= UVnum && UVnum <= 2 {
                // 낮음
                uvImage.image = UIImage(named: "uv1"+".png")
            }
            else if 3 <= UVnum && UVnum <= 5 {
                // 보통
                uvImage.image = UIImage(named: "uv2"+".png")
            }
            else if 6 <= UVnum && UVnum <= 7 {
                // 높음
                uvImage.image = UIImage(named: "uv3"+".png")
            }
            else if 8 <= UVnum && UVnum <= 10 {
                // 매우 높음
                uvImage.image = UIImage(named: "uv4"+".png")
            }
            else if 11 <= UVnum {
                // 위험
                uvImage.image = UIImage(named: "uv5"+".png")
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
    @objc func updateDiscomfort(){
        discomfortLabel.text = MainWeather.discomfort
        
        if MainWeather.discomfort == ""{
            discomfortImage.image = UIImage(named: "discomfort1"+".png")
        }
        else {
            var discomfortNum = Int(MainWeather.discomfort)!
            
            if discomfortNum < 68 {
                // 낮음: 전원 쾌적함을 느낌
                discomfortImage.image = UIImage(named: "discomfort1"+".png")
            }
            else if 68 <= discomfortNum && discomfortNum < 75 {
                // 보통: 불쾌감을 느끼기 시작함
                discomfortImage.image = UIImage(named: "discomfort2"+".png")
            }
            else if 75 <= discomfortNum && discomfortNum < 80 {
                // 높음: 50% 정도 불쾌감을 느낌
                discomfortImage.image = UIImage(named: "discomfort3"+".png")
            }
            else if 80 <= discomfortNum {
                // 매우 높음: 전원 불쾌감을 느낌
                discomfortImage.image = UIImage(named: "discomfort4"+".png")
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
    @objc func updateAirDust(){
        
        dust10numLabel.text = MainWeather.pm10Val
        dust25numLabel.text = MainWeather.pm25Val
        
        // 초미세먼지
        if MainWeather.pm25Val == "" {
            dust25Image.tintColor = UIColor.systemGray2
        }
        else{
            //  0~15 / 16~35 / 36~75 / 76~
            let dust25 = Int(MainWeather.pm25Val)!
            if 0 <= dust25 && dust25 <= 15 {
                dust25Image.tintColor = UIColor.systemBlue
                dust25textLabel.text = "좋음"
            }
            else if 16 <= dust25 && dust25 <= 35 {
                dust25Image.tintColor = UIColor.systemGreen
                dust25textLabel.text = "보통"
            }
            else if 36 <= dust25 && dust25 <= 75 {
                dust25Image.tintColor = UIColor.systemYellow
                dust25textLabel.text = "나쁨"
            }
            else if 76 <= dust25 {
                dust25Image.tintColor = UIColor.systemRed
                dust25textLabel.text = "매우나쁨"
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
                dust10textLabel.text = "좋음"
            }
            else if 31 <= dust10 && dust10 <= 80 {
                dust10Image.tintColor = UIColor.systemGreen
                dust10textLabel.text = "보통"
            }
            else if 81 <= dust10 && dust10 <= 150 {
                dust10Image.tintColor = UIColor.systemYellow
                dust10textLabel.text = "나쁨"
            }
            else if 151 <= dust10 {
                dust10Image.tintColor = UIColor.systemRed
                dust10textLabel.text = "매우나쁨"
            }
        }
        
        self.view.layoutIfNeeded()
    }
    
}
