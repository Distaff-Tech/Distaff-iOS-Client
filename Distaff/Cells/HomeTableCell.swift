//
//  HomeTableCell.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    var callBackLike:(()->())?
    var callBackProfileTapped:(()->())?
    var callBackComment:(()->())?
    var callBackSavedInCollection:(()->())?
    var callBackMessage:(()->())?
    var callBackMenuOptions:(()->())?
    var callBackBuy:(()->())?
    
    @IBOutlet weak var profilePic: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPostDescription: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnSaveCollection: UIButton!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet var stackviewOptions: UIStackView!
    
    
    var postObject:postListDetail? {
        didSet {
            profilePic.imageView?.contentMode = .scaleAspectFill
            profilePic.setSdWebImage(url: postObject?.image ?? "")
            lblUserName.text = postObject?.post_type == "promotional" ? "Promotional Post" : postObject?.fullname ?? ""
            lblLocation.text = CommonMethods.timeAgoSinceDate(CommonMethods.dateAndTimeFormat(utcDate: postObject?.created_time ?? "") ?? Date())
            lblPostDescription.text = postObject?.post_description
            lblLikeCount.text = String(postObject?.total_likes ?? 0)
            lblCommentCount.text = String(postObject?.total_comments ?? 0)
            btnLike.isSelected = postObject?.post_like ?? false ? true : false
            btnSaveCollection.isSelected = postObject?.post_fav ?? false ? true : false
            postImage.setSdWebImage(url: postObject?.post_image?.count ?? 0 > 0 ? postObject?.post_image?[0] ?? "" : "")
            btnBuy.setTitle("\("BUY ($\(postObject?.price ?? "0.0"))")", for: .normal)
            btnBuy.isHidden = postObject?.post_type == "promotional"
            stackviewOptions.isHidden = btnBuy.isHidden
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
        callBackProfileTapped?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func didTappedMessage(_ sender: UIButton) {
        callBackMessage?()
        
    }
    
    @IBAction func didTappedLike(_ sender: UIButton) {
        callBackLike?()
    }
    
    @IBAction func didTappedComment(_ sender: UIButton) {
        callBackComment?()
    }
    
    @IBAction func didTappedBuy(_ sender: UIButton) {
        callBackBuy?()
        
    }
    @IBAction func didTappedSavedInCollection(_ sender: UIButton) {
        callBackSavedInCollection?()
    }
    
    @IBAction func didTappedMenuOption(_ sender: UIButton) {
        callBackMenuOptions?()
    }
    
}
