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
        
        
        print("이건 돼?")
        NotificationCenter.default.addObserver(self, selector: #selector(updateSecond), name: NSNotification.Name(rawValue: "fin2"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fin2"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {

//        NotificationCenter.default.addObserver(self, selector: #selector(self.updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateDetailWeather), name: NSNotification.Name(rawValue: "Weather"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateUV), name: NSNotification.Name(rawValue: "UV"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateDiscomfort), name: NSNotification.Name(rawValue: "discomfort"), object: nil)
//
//        print("이건 돼?")
//        NotificationCenter.default.addObserver(self, selector: #selector(updateSecond), name: NSNotification.Name(rawValue: "fin2"), object: nil)
        
    }
    
    @objc func updateSecond() {
        print("넌 왜 안돼 ")
        if MainViewController.updated {
            self.updateDetailWeather()
            self.updateAirDust()
            self.updateDiscomfort()
            self.updateUV()
           
            self.updateColor()
            self.view.layoutIfNeeded()
        }
    }
    
    func updateDetailWeather(){
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
    
    func updateUV(){
        uvLabel.text = MainWeather.UVlight
        uvImage.image = UIImage(named: MainWeather.UVlightImage)
        
        self.view.layoutIfNeeded()
    }
    
    func updateDiscomfort(){
        discomfortLabel.text = MainWeather.discomfort
        discomfortImage.image = UIImage(named: MainWeather.discomfortImage)
            
        self.view.layoutIfNeeded()
    }
    
    func updateAirDust(){
        dust10numLabel.text = MainWeather.pm10Val
        dust10Image.tintColor = MainWeather.pm10Color
        dust10textLabel.text = MainWeather.pm10State
        dust25numLabel.text = MainWeather.pm25Val
        dust25Image.tintColor = MainWeather.pm25Color
        dust25textLabel.text = MainWeather.pm25State
        
        self.view.layoutIfNeeded()
    }
    
}
