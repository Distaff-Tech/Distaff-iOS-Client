//
//  ClothSizeCollectionCell.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ClothSizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSize: UILabel!
    var sizeObj:SizeModel? {
        didSet {
            lblSize.text = sizeObj?.size
            lblSize.textColor = sizeObj?.isSelected == true ? .white : AppColors.appColorBlue
            lblSize.backgroundColor = sizeObj?.isSelected == true ? AppColors.appColorBlue : .white
            
        }
        
    }
    
    
}
