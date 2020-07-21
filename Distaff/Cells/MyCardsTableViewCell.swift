//
//  MyCardsTableViewCell.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MyCardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewCard: UIImageView!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    
    var callBackDeleteCard : (()->())?
    var cardsObject:Cards? {
        didSet {
            imgViewCard.setSdWebImage(url: cardsObject?.card_image ?? "")
            lblCardNumber.text = "XXXX - XXXX - XXXX - \(cardsObject?.last4 ?? "")"
            let expiryYear = String(String(cardsObject?.exp_year ?? 2020).dropFirst(2))
            lblExpiryDate.text =  "\(cardsObject?.exp_month ?? 1)\("/")\(expiryYear)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton) {
      callBackDeleteCard?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
