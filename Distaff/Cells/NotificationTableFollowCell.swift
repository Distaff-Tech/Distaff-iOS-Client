//
//  NotificationTableFollowCell.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class NotificationTableFollowCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblNotificationText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnFolow: UIButton!
    @IBOutlet weak var btnFollowWidthAnchor: NSLayoutConstraint!
    
    
    var callBackTappedProfile : (()->())?
    
    
    
    var notificationObject:NotificationData?  {
        didSet {
            lblTime.text = CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: notificationObject?.notification_time ?? "") ?? Date())
            profilePic.setSdWebImage(url: notificationObject?.sender_image ?? "")
            btnFolow.isHidden = notificationObject?.follow_status ?? false == true ? true : false
            btnFollowWidthAnchor.constant =  btnFolow.isHidden ? 0 : 115
            self.layoutIfNeeded()
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name:AppFont.fontRegular, size: 14.0)! ]
            let myString = NSMutableAttributedString(string: "\(notificationObject?.sender_name ?? "")\(" ")\(notificationObject?.message ?? "")", attributes: myAttribute )
            let senderName = notificationObject?.sender_name ?? ""
            let myRange = NSRange(location: 0, length: senderName.count )
            let anotherAttribute = [ NSAttributedString.Key.foregroundColor:AppColors.appColorBlue,NSAttributedString.Key.font: UIFont(name:AppFont.fontSemiBold, size: 14.0)!]
            myString.addAttributes(anotherAttribute, range: myRange)
            lblNotificationText.attributedText = myString
            lblNotificationText.isUserInteractionEnabled = true
            lblNotificationText.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
            
        }
        
    }
    
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let range =  NSString(string: "\(notificationObject?.sender_name ?? "")\(" ")\(notificationObject?.message ?? "")").range(of: notificationObject?.sender_name ?? "", options: String.CompareOptions.caseInsensitive)
        
        if gesture.didTapAttributedTextInLabel(label: lblNotificationText, inRange: range) {
            callBackTappedProfile?()
        }
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didTappedFollow(_ sender: UIButton) {
        callBackTappedProfile?()
        
    }
    
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
        callBackTappedProfile?()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
