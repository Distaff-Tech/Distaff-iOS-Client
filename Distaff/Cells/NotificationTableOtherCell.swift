//
//  NotificationTableOtherCell.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class NotificationTableOtherCell: UITableViewCell {
    
    @IBOutlet weak var lblNotificationText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var postImage: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    
    var callBackPostImageClick : (()->())?
    var callBackTappedProfile : (()->())?
    
    var notificationObject:NotificationData?  {
        didSet {
            lblTime.text = CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: notificationObject?.notification_time ?? "") ?? Date())
            profilePic.setSdWebImage(url: notificationObject?.sender_image ?? "")
               postImage.imageView?.contentMode = .scaleAspectFill
            postImage.setSdWebImage(url: notificationObject?.post_image ?? "")
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
    @IBAction func didTappedPostImage(_ sender: UIButton) {
        callBackPostImageClick?()
    }
    
    @IBAction func didtappedProfile(_ sender: UIButton) {
        callBackTappedProfile?()
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
