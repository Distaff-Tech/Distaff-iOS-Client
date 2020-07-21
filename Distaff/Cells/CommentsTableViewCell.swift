//
//  CommentsTableViewCell.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var callBackProfileTapped : (()->())?
    
    
    var commentsObject:commentArray? {
        didSet {
            imgViewProfile.setSdWebImage(url: commentsObject?.image ?? "")
            lblUserName.text = commentsObject?.fullname
            lblComment.text = CommonMethods.decode(commentsObject?.comment ?? "")
            lblTime.text = CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: commentsObject?.created_time ?? "") ?? Date())
        }
        
    }
    
    @IBAction func didTappedProfile(_ sender: Any) {
        callBackProfileTapped?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
