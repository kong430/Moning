//
//  DatePickerCell.swift
//  Moning
//
//  Created by Yun Jeong on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
