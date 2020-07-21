//
//  HomeVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class HomeVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tablViewHome: UITableView!
    @IBOutlet weak var btnCart: MIBadgeButton!
    @IBOutlet weak var notificationBageBtn: MIBadgeButton!
    
    //MARK:VARIABLE(S)
    let objHomeVM = HomeVM()
    
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleTabbarVisibility(shouldHide: false)
        handleUnreadNotificationUI(btn: notificationBageBtn)
        removeRefreshControl()
        if Variables.shared.shouldLoadPostData {
            if self.objHomeVM.postListArray.count > 0 {
                self.tablViewHome.scrollToTop(indexPath: NSIndexPath(item: 0, section: 0))
            }
            objHomeVM.pageNumber = 1
            fetchHomePostListing(shouldAnimate: true)
        }
        else {
            showCartCount(btnCart: btnCart)
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        Variables.shared.shouldLoadPostData = false
    }
    
    override func refreshData() {
        objHomeVM.pageNumber = 1
        fetchHomePostListing(refreshControl: refreshControl, shouldAnimate: false)
    }
    
}

//MARK:ALL METHODS(S)
extension HomeVC {
    func prepareUI() {
        self.tablViewHome.estimatedRowHeight = 383.0
        self.tablViewHome.rowHeight = UITableView.automaticDimension
        self.tablViewHome.setContentInsect(edgeInsets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        addRefreshControlInTable(tableView: self.tablViewHome)
    }
    
    func fetchHomePostListing(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool) {
        objHomeVM.callPostListsApi(refreshControl:refreshControl,shouldAnimate: shouldAnimate) { (data) in
            self.tablViewHome.reloadData()
            self.btnCart.badgeString = data?.cart_count == 0 ? "" : "\(data?.cart_count ?? 0)"
            userdefaultsRef.set( data?.cart_count ?? 0, forKey: UserDefaultsKeys.cartCount)
            self.tablViewHome.showNoDataLabel(message: Messages.NoDataMessage.noPostFound, arrayCount: self.objHomeVM.postListArray.count)
            var userObject = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))
            userObject?.login_type = data?.login_type ?? "e"
            userdefaultsRef.set(encodable: userObject, forKey: UserDefaultsKeys.userInfo)
            if let bankInfo = data?.bank_detail {
              userdefaultsRef.set(encodable: bankInfo, forKey: UserDefaultsKeys.bankInfo)
            }
        }
    }
    
}

//MARK:ALL ACTION(S)
extension HomeVC {
    @IBAction func didTappedNotification(_ sender: UIButton) {
       pushToViewController(VC: ViewControllersIdentifers.notificationVC)
        
        
    }
    
    @IBAction func didTappedCart(_ sender: UIButton) {
        handleCartButtonSelection(btnCart: btnCart)
    }
}
