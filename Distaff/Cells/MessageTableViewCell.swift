//
//  MessageTableViewCell.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    var messageObject:chatHistoryData? {
        didSet {
            let url = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id == messageObject?.sender_id ?? 0 ? messageObject?.receiver_image ?? "" :  messageObject?.sender_image ?? ""
            profilePic.setSdWebImage(url: url)
            lblUserName.text = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id == messageObject?.sender_id ?? 0 ? messageObject?.receiver_name ?? "" :  messageObject?.sender_name ?? ""
            lblComment.text = CommonMethods.decode(messageObject?.message ?? "")
            lblTime.text =  CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: messageObject?.created_time ?? "") ?? Date())
            containerView.borderColor = AppColors.appColorBlue
            containerView.borderWidth = messageObject?.is_sent_by_me ?? false == true ? 0 : messageObject?.is_read ?? 0 != 0  ? 0 : 0.5
            let selectedColor = #colorLiteral(red: 0.8431372549, green: 0.9176470588, blue: 0.9176470588, alpha: 0.5892016267)
            let unSelectionColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            containerView.backgroundColor = messageObject?.is_sent_by_me ?? false == true ? unSelectionColor : messageObject?.is_read ?? 0 != 0 ? unSelectionColor : selectedColor
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
    
}
