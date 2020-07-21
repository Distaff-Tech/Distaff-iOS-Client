//
//  ShoppingFooterTableViewCell.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ShoppingFooterTableViewCell: UITableViewCell {

    var callBackChange: (()->())?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet var lblServiceCharge: UILabel!
    @IBOutlet var lblServiceChargeTitle: UILabel!
    
    @IBOutlet weak var shoppingAddressView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func didTappedChange(_ sender: UIButton) {
     callBackChange?()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
