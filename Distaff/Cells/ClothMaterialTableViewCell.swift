//
//  ClothMaterialTableViewCell.swift
//  Distaff
//
//  Created by netset on 12/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ClothMaterialTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    var clothObject:FabricModel? {
        didSet {
            lblTitle.text = clothObject?.fabric
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
