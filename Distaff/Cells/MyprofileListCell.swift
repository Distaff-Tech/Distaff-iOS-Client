//
//  MyprofileListCell.swift
//  Distaff
//
//  Created by netset on 16/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MyprofileListCell: UICollectionViewCell {
    
    var callBackFollowUnfollow : (() -> ())?
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lbloFullName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    
    override class func awakeFromNib() {
        
        
    }
    
    @IBAction func didTappedFollowUnFollow(_ sender: UIButton) {
      callBackFollowUnfollow?()
        
    }
}
