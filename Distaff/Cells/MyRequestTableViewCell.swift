//
//  MyRequestTableViewCell.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MyRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    
    var callBackAccepted : (() -> ())?
     var callBackDeclined : (() -> ())?
    
    var orderObject:List? {
        didSet {
            profilePic.setSdWebImage(url: orderObject?.post_image ?? "")
            lblUserName.text = "Order By \(orderObject?.fullname ?? "")"
            lblDescription.text = orderObject?.post_description ?? ""
            lblPrice.text = "$\(orderObject?.price ?? "0")"
            lblColor.text = "Color: \(orderObject?.colour_name ?? "")"
            lblSize.text = "Size: \(orderObject?.size_name ?? "")"
            lblOrderStatus.text = orderObject?.order_status == 1 ? "Accepted" : "Declined"
            lblOrderStatus.textColor = orderObject?.order_status == 1 ? AppColors.appColorBlue : .red
            stackViewHeight.constant = orderObject?.order_status == 0 ? 30 : 0
            stackView.isHidden =  orderObject?.order_status == 0 ? false : true
            lblOrderStatus.isHidden = orderObject?.order_status == 0 ? true : false
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        profilePic.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    @IBAction func didTappedAccept(_ sender: UIButton) {
        callBackAccepted?()
        
        
    }
    @IBAction func didTappedDecline(_ sender: UIButton) {
         callBackDeclined?()
    }
}
