//
//  MyProfileVM.swift
//  Distaff
//
//  Created by netset on 16/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class MyProfileVM {
    
    var cellType = 0
    var isFromPush = false
    var shouldLoadData = false
    var pageNumber = 1
    var doesNxtPageExist = false
    var profileData:GetProfileModel?
    
    var followListArray = [FollowData]()
    var followingListArray = [FollowData]()
    var followListFilterArray = [FollowData]()
    var followingListFilterArray = [FollowData]()
    
    
    func callGetProfileApi(ref:MyProfileVC ,userId:Int,refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool) {
        let url = "\(WebServicesApi.userprofile)\(userId)"
        Services.getRequest(url: url, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(GetProfileModel.self, from: responseData)
                self.profileData = data
                self.doesNxtPageExist = data.has_next ?? false
                self.displayProfileData(ref: ref)
                Variables.shared.shouldLoadProfileData = false
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    func displayProfileData(ref:MyProfileVC) {
        if !ref.isMyProfile {
            ref.lblTitle.text = profileData?.data?.fullname ?? ""
            ref.btnFollow.isSelected = profileData?.data?.follow_status ?? false
        }
        ref.transparentProfilePic.setSdWebImage(url: profileData?.data?.image ?? "")
        ref.imgViewProfile.setSdWebImage(url: profileData?.data?.image ?? "")
        ref.lblFullName.text = profileData?.data?.fullname ?? ""
        ref.lblUserName.text = "\("( ")\(profileData?.data?.user_name ?? "")\(" )")"
        ref.lblAddress.text = profileData?.data?.address ?? ""
        ref.lblDescription.text = profileData?.data?.about_me ?? ""
        ref.lblGender.text = profileData?.data?.gender == "M" ? "Male" : "Female"
        ref.lblPostCount.text = "\(profileData?.data?.post_count ?? 0)"
        ref.lblPosts.text = profileData?.data?.post_count ?? 0 <= 1 ? "POST" :"POSTS"
        ref.lblFollowersCount.text = "\(profileData?.data?.total_follower ?? 0)"
        ref.lblFollowers.text = profileData?.data?.total_follower ?? 0 <= 1 ? "FOLLOWER" :"FOLLOWERS"
        ref.lblFollowingCount.text = "\(profileData?.data?.total_following ?? 0)"
        cellType = 0
        ref.lblPostCount.textColor = ref.objProfileVM.cellType == 0 ? AppColors.appColorBlue : .black
        ref.lblPosts.textColor = ref.objProfileVM.cellType == 0 ? AppColors.appColorBlue : .black
        ref.lblFollowersCount.textColor = ref.objProfileVM.cellType == 1 ? AppColors.appColorBlue : .black
        ref.lblFollowers.textColor = ref.objProfileVM.cellType == 1 ? AppColors.appColorBlue : .black
        ref.lblFollowingCount.textColor = ref.objProfileVM.cellType == 2 ? AppColors.appColorBlue : .black
        ref.lblFollowing.textColor = ref.objProfileVM.cellType == 2 ? AppColors.appColorBlue : .black
        ref.searchHeightAnchor.constant = ref.objProfileVM.cellType == 0 ? 0.0 : 44.0
        ref.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noPost, arrayCount:profileData?.data?.post_images?.count ?? 0)
        ref.collectionViewPosts.reloadData()
        
    }
    
    
    
    
    
    func callGetFollowersListApi(userId:Int, _ completion:@escaping([FollowData]) -> Void) {
        Services.postRequest(url:  WebServicesApi.get_followers, param: [Follow_FollowingList.user_id:userId], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(FollowListModel.self, from: responseData)
                self.followListArray = data.data ?? []
                self.followListFilterArray =  self.followListArray
                completion(self.followListArray)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    func callGetFollowingListApi(userId:Int, _ completion:@escaping([FollowData]) -> Void) {
        Services.postRequest(url:  WebServicesApi.get_following, param: [Follow_FollowingList.user_id:userId], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(FollowListModel.self, from: responseData)
                self.followingListArray = data.data ?? []
                self.followingListFilterArray =  self.followingListArray
                completion(self.followingListArray)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
}


