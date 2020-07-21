//
//  SettingsTableOtherCell.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SettingsTableOtherCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    var settingsObject:Settings? {
        didSet {
            lblTitle.text = settingsObject?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
