//
//  PastOrdersTableViewCell.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class PastOrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblOrderDecline: UILabel!
    @IBOutlet weak var lblDeclineHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var lblColor: UILabel!
    
    var orderObject:List? {
        didSet {
            profilePic.setSdWebImage(url: orderObject?.post_image ?? "")
            lblUserName.text = "Design By \(orderObject?.fullname ?? "")"
            lblDescription.text = orderObject?.post_description ?? ""
            let price = Double(orderObject?.price ?? "0.00") ?? 0.00
            let servicePrice = ((price * (orderObject?.serviceCharge ?? 0.0) ) / 100).truncate(places: 2)
            let totalPrice = (price + servicePrice).calculateCurrency(fractionDigits: 2)
            lblPrice.text = "$\(totalPrice)"
            lblColor.text = "Color: \(orderObject?.colour_name ?? "")"
            lblSize.text = "Size: \(orderObject?.size_name ?? "")"
            lblDeclineHeightAnchor.constant =  orderObject?.order_status == 2 || orderObject?.order_status == -2  ? 15 : 0
            lblOrderDecline.isHidden = orderObject?.order_status == 2 || orderObject?.order_status == -2 ? false : true
            lblOrderDecline.text = orderObject?.order_status == 2 ? "This order was declined by \(orderObject?.post_by ?? "")" : "Cancelled by you"
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
