//
//  MessageVC.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class MessageVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewMessage: UITableView!
    @IBOutlet weak var btnCart: MIBadgeButton!
    
    //MARK:VARIABLE(S)
    let objVMMessage = MessageVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showCartCount(btnCart: btnCart)
        handleTabbarVisibility(shouldHide: false)
        removeRefreshControl()
        if self.objVMMessage.recentMessageList.count > 0 {
            self.tblViewMessage.scrollToTop(indexPath: NSIndexPath(item: 0, section: 0))
        }
        objVMMessage.pageNumber = 1
        getRecentChatList(shouldAnimate: !objVMMessage.hasLoadChatData)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refreshRecentList),
            name:NSNotification.Name(rawValue: NotificationObservers.refreshChatList),
            object: nil)
    }
    
    @objc  func refreshRecentList(notification: NSNotification){
        objVMMessage.pageNumber = 1
        getRecentChatList(refreshControl: refreshControl, shouldAnimate: false)
    }
    
    override func refreshData() {
        objVMMessage.pageNumber = 1
        getRecentChatList(refreshControl: refreshControl, shouldAnimate: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if tblViewMessage.isEditing {
            tblViewMessage.isEditing = false
        }
        removeAllObserversAdded()
    }
    
}

//MARK:ALL METHOD(S)
extension MessageVC {
    func  prepareUI() {
        self.tblViewMessage.estimatedRowHeight = 95
        self.tblViewMessage.rowHeight = UITableView.automaticDimension
        self.tblViewMessage.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0);
        addRefreshControlInTable(tableView: self.tblViewMessage)
    }
    

    
    func getRecentChatList(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool) {
        objVMMessage.callRecentChatListsApi(refreshControl: refreshControl, shouldAnimate: shouldAnimate) { (data) in
            self.tblViewMessage.reloadData()
            self.tblViewMessage.showNoDataLabel(message:Messages.NoDataMessage.noChatList, arrayCount: self.objVMMessage.recentMessageList.count)
            self.btnCart.badgeString = data.cart_count == 0 ? "" : "\(data.cart_count ?? 0)"
        }
    }
    
}
//MARK:ALL ACTION(S)
extension MessageVC {
    @IBAction func didTappedCart(_ sender: UIButton) {
        handleCartButtonSelection(btnCart: btnCart)
    }
}
