//
//  SelectPaymentTableCell.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SelectPaymentTableCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var radioBtn: UIButton!
    
    var callBackRadioBtn:(()->())?
    var cardObject:Cards? {
        
        didSet {
            cardImage.setSdWebImage(url: cardObject?.card_image ?? "")
            lblCardNo.text = "XXXX - XXXX - XXXX - \(cardObject?.last4 ?? "")"
            let expiryYear = String(String(cardObject?.exp_year ?? 2020).dropFirst(2))
            lblExpiryDate.text =  "\(cardObject?.exp_month ?? 1)\("/")\(expiryYear)"
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func didPressesRadioButton(_ sender: UIButton) {
        callBackRadioBtn?()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
