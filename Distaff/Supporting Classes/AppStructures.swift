//
//  AppStructures.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

struct Settings {
    var title:String?
}

struct WebView {
    var title:String?
    var url:String
}


// Dummy
struct MyCards {
    var cardImage:UIImage?
    var cardNo:String?
    var expiryDate:String?
    var isCardSlected:Bool? = nil
}

struct Comments {
    var profilePic:UIImage?
    var userName:String?
    var comment:String?
    var time:String?
}

struct HomePost {
    var profilePic:UIImage?
    var userName:String?
    var location:String?
    var comment:String?
    var postImage:UIImage?
    var likeCount:String?
    var commentCount:String?
    var isLiked:Bool?
    var isSavedInCollection:Bool?
}


struct SelectAddress {
    var usernName:String?
    var address:String?
    var phoneNo:String?
    var isSelected:Bool?
}

struct RecentChat {
    var profilePic:UIImage?
    var userName:String?
    var lastComment:String?
    var time:String?
    var isSeen:Bool?
}


struct Chat {
    var profilePic:UIImage?
    var message:String?
    var time:String?
    var isSendByMe:Bool?
}


struct NotificationList {
    var profilePic:UIImage?
    var title:String?
    var time:String?
    var userName:String?
    var postImage:UIImage?
}


struct MyOrders {
    var list:[MyOrderList]?
    var date:String?
}

struct MyOrderList {
    var profilePic:UIImage?
    var username:String?
    var address:String?
    var price:String?
    
}


struct UsersList {
    var profilePic:UIImage?
    var username:String?
    var fullName:String?
    
}



struct SocialInfo_User {
    var email:String? = nil
    var socialId:String? = nil
    var userName:String? = nil
    var fullName:String? = nil
    var profilePic:URL?
    var loginType:String? = nil
}


struct ColorScheme {
    var colorId:Int?
    var image:UIImage?
    var isSelected:Bool? = false
}





