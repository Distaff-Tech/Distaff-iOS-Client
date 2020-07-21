//
//  NotificationVM.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class NotificationVM {
    
    var notificationArray = [NotificationData]()
    
    func callNotificationListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,completion:@escaping() -> Void) {
        Services.getRequest(url: WebServicesApi.notificationList, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(NotificationListModel.self, from: responseData)
                self.notificationArray = data.data ?? []
                Variables.shared.hasPendingNotifications = false
                CommonMethods.clrAllRemoteNotifications()
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    func callRemoveNotificationListApi(shouldAnimate:Bool,completion:@escaping() -> Void) {
        Services.getRequest(url: WebServicesApi.deleteNotification, shouldAnimateHudd: shouldAnimate) { (responseData) in
            do {
                self.notificationArray.removeAll()
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
}

