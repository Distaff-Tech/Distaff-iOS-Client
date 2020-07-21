//
//  ClothColorCollectionCell.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ClothColorCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgViewColor: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var callBackDelete : (() ->())?
     override func awakeFromNib() {
            super.awakeFromNib()
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton) {
        
     callBackDelete?()
        
    }
}
