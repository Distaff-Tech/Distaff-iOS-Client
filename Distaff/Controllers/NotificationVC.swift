//
//  NotificationVC.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class NotificationVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewNotification: UITableView!
    @IBOutlet weak var btnClr: UIButton!
    
    
    //MARK:VARIABLE(S)
    let objNotificationVM = NotificationVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        removeAllObserversAdded()
    }
    
    
    override func refreshData() {
        getNotificationList(refreshControl: refreshControl, shoulLoad: false)
    }
    
    @IBAction func didTappedClearAll(_ sender: UIButton) {
        self.showAlertWithActionAndCancel(message:Messages.DialogMessages.deleteAllNotifications) {
            self.objNotificationVM.callRemoveNotificationListApi(shouldAnimate: true) {
                self.tblViewNotification.reloadData()
                self.btnClr.isHidden = self.objNotificationVM.notificationArray.count > 0 ? false : true
                self.tblViewNotification.showNoDataLabel(message:Messages.NoDataMessage.noNotification, arrayCount: self.objNotificationVM.notificationArray.count)
            }
        }
        
    }
}
//MARK:ALL METHODS(S)
extension NotificationVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        tblViewNotification.removeExtraSeprators()
        getNotificationList(shoulLoad: true)
        addRefreshControlInTable(tableView: self.tblViewNotification)
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(self.refreshNotificationList),
               name:NSNotification.Name(rawValue: NotificationObservers.refreshNotificationList),
               object: nil)
        
        
    }
    
    @objc  func refreshNotificationList(notification: NSNotification) {
        Variables.shared.hasPendingNotifications = false
         getNotificationList(refreshControl: refreshControl, shoulLoad: false)
    }
    
    func getNotificationList(refreshControl:UIRefreshControl? = nil,shoulLoad:Bool) {
        objNotificationVM.callNotificationListsApi(refreshControl: refreshControl, shouldAnimate: shoulLoad) {
            self.btnClr.isHidden = self.objNotificationVM.notificationArray.count > 0 ? false : true; self.tblViewNotification.showNoDataLabel(message:Messages.NoDataMessage.noNotification, arrayCount: self.objNotificationVM.notificationArray.count)
            self.tblViewNotification.reloadData()
        }
    }
}

//MARK:ALL ACTION(S)
extension NotificationVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    
    
}

