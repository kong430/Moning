//
//  SecondViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/17.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       NotificationCenter.default.addObserver(self, selector: #selector(updateAirDust), name: NSNotification.Name(rawValue: "AirDust"), object: nil)
    }
    
    @objc func updateAirDust(){
        // ui update
        self.view.layoutIfNeeded()
    }
    
}
