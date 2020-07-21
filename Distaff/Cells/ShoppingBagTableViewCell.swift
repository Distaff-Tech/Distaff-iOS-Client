//
//  ShoppingBagTableViewCell.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ShoppingBagTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblColor: UILabel!
    
    var callBackDeleteItem : (() ->())?
    var callBackPostImageTapped : (() ->())?
    
    var object:ShoppingBagData? {
        didSet {
            profilePic.setSdWebImage(url: object?.post_image ?? "")
            lblUserName.text = "Designed by \( object?.design_by ?? "")"
            lblAddress.text = object?.post_description ?? ""
            lblPrice.text = "$\(object?.price ?? "0.00")"
            lblColor.text = "Color: \(object?.colour_name ?? "")"
            lblSize.text = "Size: \(object?.size_name ?? "")"
        }
    }
    
    @IBAction func didTappedPostButton(_ sender: UIButton) {
        callBackPostImageTapped?()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton) {
        callBackDeleteItem?()
        
    }
}
