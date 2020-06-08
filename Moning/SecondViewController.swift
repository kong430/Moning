//
//  SecondViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/17.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func updateAirDust(){
        print("??????????")
        test.text = MainWeather.pm10Val + "/" + MainWeather.pm25Val
        self.view.layoutIfNeeded()
    }
    
}
