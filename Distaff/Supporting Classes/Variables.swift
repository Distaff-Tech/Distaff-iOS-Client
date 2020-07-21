//
//  Variables.swift
//  Distaff
//
//  Created by netset on 06/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class Variables :NSObject {
    static let shared = Variables()
    
    var userSocialInfo:SocialInfo_User?
    
    var sizeListArray = [SizeModel]()
    var fabricListArray = [FabricModel]()
    var colorListArray = [ColourModel]()
    var imageColorArray = [ColorScheme]()
    var selectedColorId :Int?
    var placeholderImage = #imageLiteral(resourceName: "noImage")
    var shouldLoadPostData = true
    var shouldLoadProfileData = true
    var hasPendingNotifications = false
    var isFromPushTappedForDisable = false
}


