//
//  AlarmCustomCell.swift
//  Moning
//
//  Created by Yun Jeong on 2020/06/01.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class AlarmCustomCell: UITableViewCell {
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
