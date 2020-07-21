//
//  SettingsTableNoticationCell.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SettingsTableNoticationCell: UITableViewCell {

    @IBOutlet weak var notificationSwitch: UISwitch!
    var callbackValueChanged : ((_ isSwitchOn:Bool) ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func valueChanged(_ sender: UISwitch) {
        callbackValueChanged?(sender.isOn)
    }
}
