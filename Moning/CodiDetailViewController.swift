//
//  CodiDetailViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/06/23.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class CodiDetailViewController: UIViewController {
    
    var codiName = ""

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var codiLargeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionText.text = "사진을 클릭하면 쇼핑몰로 이동합니다. 밑에 사진 이름은 "+codiName
        codiLargeImage.image = UIImage(named: "01n.png")

    }
    
    
}
