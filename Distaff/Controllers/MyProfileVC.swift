//
//  MyProfileVC.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit


class MyProfileVC: BaseClass {
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var collectionViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var collectionViewPosts: UICollectionView!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblFollowingCount: UILabel!
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblPostCount: UILabel!
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var searchHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackViewFollow: UIStackView!
    @IBOutlet weak var btnFollowHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var transparentProfilePic: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var imgViewProfile: UIImageView!
    
    //MARK:VARIABLE(S)
    let objProfileVM = MyProfileVM()
    var isMyProfile = true
    var passedUserId:Int?
    
    var callBackFollowStatus : ((_ isSelected:Bool) -> ())?
    
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleTabbarVisibility(shouldHide: !isMyProfile ? true : false)
        hideNavigationBar()
        if Variables.shared.shouldLoadProfileData {
            callGetProfileApi(shouldAnimate: true)
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refreshProfile),
            name:NSNotification.Name(rawValue: NotificationObservers.refreshProfile),
            object: nil)
    }
    
    @objc  func refreshProfile(notification: NSNotification){
        objProfileVM.isFromPush = true
        let userInfo  = notification.userInfo as? [AnyHashable : Any]
        if isMyProfile || Int(userInfo?["sender_id"] as? String ?? "0") == passedUserId {
            
            if objProfileVM.cellType == 0 || objProfileVM.cellType == 2 {
                callGetProfileApi(shouldAnimate: false)
            }
            else {
                self.objProfileVM.callGetFollowersListApi(userId: (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0) { (data) in
                    self.lblFollowersCount.text = "\(data.count)"
                    self.lblFollowers.text = data.count <= 1 ? "FOLLOWER" :"FOLLOWERS"
                    self.collectionViewPosts.reloadData()
                    self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollower, arrayCount: self.objProfileVM.followListFilterArray.count)
                }
            }
            
        }
    }
    
    
    override func refreshData() {
        callGetProfileApi(shouldAnimate: false, refreshControl: refreshControl)
        
    }
    
    override  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    override func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    override func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        if objProfileVM.cellType == 1 {
            objProfileVM.followListFilterArray = objProfileVM.followListArray
            self.collectionViewPosts.reloadData()
            self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollower, arrayCount: self.objProfileVM.followListFilterArray.count)
            
        }
            
        else {
            objProfileVM.followingListFilterArray = objProfileVM.followingListArray
            self.collectionViewPosts.reloadData()
            self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollowing, arrayCount: self.objProfileVM.followingListFilterArray.count)
        }
        
        
        
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if objProfileVM.cellType == 1 {
            objProfileVM.followListFilterArray = searchBar.text?.isEmpty ?? false ?  objProfileVM.followListArray : objProfileVM.followListArray.filter({($0.fullname?.range(of: searchBar.text!, options: .caseInsensitive) != nil)})
            self.collectionViewPosts.reloadData()
            self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollower, arrayCount: self.objProfileVM.followListFilterArray.count)
            
            
        }
        else  {
            if objProfileVM.cellType == 2 {
                objProfileVM.followingListFilterArray = searchBar.text?.isEmpty ?? false ?  objProfileVM.followingListArray : objProfileVM.followingListArray.filter({($0.fullname?.range(of: searchBar.text!, options: .caseInsensitive) != nil)})
                self.collectionViewPosts.reloadData()
                self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollowing, arrayCount: self.objProfileVM.followingListFilterArray.count)
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scrollView.resetContentSize()
        dismissKeyboard()
        showNavigationBar()
        handleNavigationBarTranparency(shouldTranparent: false)
        removeAllObserversAdded()
    }
    
    
    
}
//MARK:ALL METHOD(S)
extension MyProfileVC {
    func prepareUI() {
        addRefreshControlInScrollView(scrollView: scrollView)
        if passedUserId != nil {
            Variables.shared.shouldLoadProfileData = true
        }
        
        btnMessage.setImage(isMyProfile == true ? #imageLiteral(resourceName: "EditProfileIcon") : #imageLiteral(resourceName: "msg") , for: .normal)
        
        stackViewFollow.isHidden = isMyProfile ? true:false
        btnFollowHeightAnchor.constant = isMyProfile ? 0:45
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        }
        else {
            let textFieldInsideUISearchBar = searchBar.value(forKey: "_searchField") as? UITextField
            textFieldInsideUISearchBar?.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
            
        }
        
        searchBar.backgroundImage = UIImage()
        btnBack.setImage(isMyProfile ? #imageLiteral(resourceName: "clock_round") : #imageLiteral(resourceName: "back-arrow"), for: .normal)
        btnSetting.isHidden = !isMyProfile
        
    }
    
    func callGetProfileApi(shouldAnimate:Bool,refreshControl:UIRefreshControl? = nil) {
        objProfileVM.callGetProfileApi(ref: self, userId: isMyProfile  == true ? (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 : passedUserId ?? 0 , refreshControl: refreshControl, shouldAnimate: shouldAnimate)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            UIApplication.shared.statusBarUIView?.backgroundColor = AppColors.appColorBlue
        }
        else {
            UIApplication.shared.statusBarUIView?.backgroundColor = nil
        }
        
    }
    
}

//MARK:ALL ACTION(S)
extension MyProfileVC  {
    @IBAction func didTappedProfile(_ sender: UIButton) {
        if  objProfileVM.profileData?.data?.image != "" {
            displayZoomSingleImages(url:objProfileVM.profileData?.data?.image ?? "")
        }
    }
    
    @IBAction func didTappedSegmentButton(_ sender: UIButton) {
        if sender.tag == 1 {
            objProfileVM.cellType = 0
            collectionViewPosts.reloadData()
            collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noPost, arrayCount: self.objProfileVM.profileData?.data?.post_images?.count ?? 0)
            if  objProfileVM.profileData?.data?.post_images?.count == 0 {
                collectionViewHeightAnchor.constant = 90.0
            }
        }
        else if sender.tag == 2{
            searchBar.text = ""
            searchBar.endEditing(true)
            
            if self.objProfileVM.cellType != 1 {
                self.objProfileVM.cellType = 1
                objProfileVM.callGetFollowersListApi(userId: isMyProfile  == true ? (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 : passedUserId ?? 0) { (data) in
                    self.lblFollowersCount.text = "\(data.count)"
                    self.lblFollowers.text = data.count <= 1 ? "FOLLOWER" :"FOLLOWERS"
                    self.collectionViewPosts.reloadData()
                    self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollower, arrayCount: self.objProfileVM.followListFilterArray.count)
                    if  self.objProfileVM.followListFilterArray.count == 0 {
                        self.collectionViewHeightAnchor.constant = 90.0
                    }
                }
            }
        }
        else {
            searchBar.text = ""
            searchBar.endEditing(true)
            if self.objProfileVM.cellType != 2 {
                self.objProfileVM.cellType = 2
                objProfileVM.callGetFollowingListApi(userId: isMyProfile  == true ? (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 : passedUserId ?? 0) { (data) in
                    self.lblFollowingCount.text = "\(data.count)"
                    self.collectionViewPosts.reloadData()
                    self.collectionViewPosts.showNoDataLabel(message: Messages.NoDataMessage.noFollowing, arrayCount: self.objProfileVM.followingListFilterArray.count)
                    if  self.objProfileVM.followingListFilterArray.count == 0 {
                        self.collectionViewHeightAnchor.constant = 90.0
                    }
                }
            }
        }
        
        lblPostCount.textColor = objProfileVM.cellType == 0 ? AppColors.appColorBlue : .black
        lblPosts.textColor = objProfileVM.cellType == 0 ? AppColors.appColorBlue : .black
        lblFollowersCount.textColor = objProfileVM.cellType == 1 ? AppColors.appColorBlue : .black
        lblFollowers.textColor = objProfileVM.cellType == 1 ? AppColors.appColorBlue : .black
        lblFollowingCount.textColor = objProfileVM.cellType == 2 ? AppColors.appColorBlue : .black
        lblFollowing.textColor = objProfileVM.cellType == 2 ? AppColors.appColorBlue : .black
        searchHeightAnchor.constant = objProfileVM.cellType == 0 ? 0.0 : 44.0
        
    }
    
    @IBAction func didTappedFollow(_ sender: UIButton) {
        CommonMethods.callFollowUnFollowApi(follow_to: objProfileVM.profileData?.data?.id ?? 0, followStatus: btnFollow.titleLabel?.text == "FOLLOW" ? 1:0) {
            self.btnFollow.isSelected =  !self.btnFollow.isSelected
            let count = Int(self.lblFollowersCount.text ?? "1")
            self.lblFollowersCount.text = self.btnFollow.isSelected ? "\((count ?? 0) + 1)" : "\((count ?? 1) - 1)"
            self.lblFollowers.text = Int(self.lblFollowersCount.text ?? "0") ?? 0 <= 1 ? "FOLLOWER" :"FOLLOWERS"
            if self.objProfileVM.cellType == 1 {
                self.objProfileVM.callGetFollowersListApi(userId: self.isMyProfile  == true ? (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 : self.passedUserId ?? 0) { (data) in
                    self.lblFollowersCount.text = "\(data.count)"
                    self.lblFollowers.text = data.count <= 1 ? "FOLLOWER" :"FOLLOWERS"
                    self.collectionViewPosts.reloadData()
                    self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollower, arrayCount: self.objProfileVM.followListFilterArray.count)
                }
            }
            
        }
        
    }
    
    @IBAction func didTappedback(_ sender: UIButton) {
        if !isMyProfile {
            callBackFollowStatus?(btnFollow.isSelected)
            PopViewController()
            Variables.shared.shouldLoadProfileData = true
        }
        else {
            pushToViewController(VC: ViewControllersIdentifers.orderHistoryVC)
        }
        
    }
    @IBAction func didTappedSetting(_ sender: UIButton) {
        pushToViewController(VC: ViewControllersIdentifers.settingsVC)
    }
    
    @IBAction func didTappedMessage(_ sender: UIButton) {
        if isMyProfile {
            if InternetReachability.sharedInstance.isInternetAvailable() {
                let targetVC = loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.createProfileVC) as? CreateProfileVC
                targetVC?.isFromEditProfile = true
                targetVC?.profileData = objProfileVM.profileData
                self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
        }
        else {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
            targetVC?.receiverId = passedUserId ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
    }
    
}


