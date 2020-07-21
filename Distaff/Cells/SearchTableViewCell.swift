//
//  SearchTableViewCell.swift
//  Distaff
//
//  Created by netset on 23/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    var callBackProfileTapped: (()->())?
    
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var btnProfile: UIButton!
    
    var serachUser: SearchUsersData? {
        didSet {
            lblUserName.text = serachUser?.user_name ?? ""
            lblFullName.text = serachUser?.fullname ?? ""
            imgViewProfile.setSdWebImage(url: serachUser?.image ?? "")
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
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
        callBackProfileTapped?()
        
    }
}
