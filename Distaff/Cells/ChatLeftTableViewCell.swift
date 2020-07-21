//
//  ChatLeftTableViewCell.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ChatLeftTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    
    var callBackProfileTapped: (() -> ())?
    
    var chatObject:ChatData? {
        didSet {
            profilePic.setSdWebImage(url: chatObject?.image ?? "")
            lblMessage.text = CommonMethods.decode(chatObject?.message ?? "")
            lblTime.text = CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: chatObject?.created_time ?? "") ?? Date())
        }
        
    }
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
        callBackProfileTapped?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
