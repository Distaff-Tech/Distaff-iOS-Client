//
//  SelectAddressTableViewCell.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SelectAddressTableViewCell: UITableViewCell {
    
    
    var callBackSelectAddress: (()->())?
    var callBackDeleteAddress: (()->())?
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var btnSelectAddress: UIButton!
    
    
    var addressObj:AddressData? {
        didSet {
            lblUserName.text = "\(addressObj?.first_name ?? "")\(" ")\(addressObj?.last_name ?? "")"
            lblAddress.text = "\(addressObj?.address ?? "")\(", \(addressObj?.city ?? "")")\(", \(addressObj?.postal_code ?? "")")"
            lblPhoneNo.text = addressObj?.phone ?? ""
            btnSelectAddress.isSelected = addressObj?.default_address ?? false ? true : false
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
    @IBAction func didTappedSelectAddress(_ sender: UIButton) {
        callBackSelectAddress?()
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton) {
        callBackDeleteAddress?()
    }
}
