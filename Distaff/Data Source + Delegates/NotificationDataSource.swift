//
//  NotificationDataSource.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension NotificationVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objNotificationVM.notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if objNotificationVM.notificationArray[indexPath.row].tag ?? "" == "follow" {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.notificationTableFollowCell) as? NotificationTableFollowCell
            cell?.notificationObject = objNotificationVM.notificationArray[indexPath.row]
            cell?.callBackTappedProfile = {
                let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
                targetVC?.isMyProfile = false
                targetVC?.passedUserId = self.objNotificationVM.notificationArray[indexPath.row].sender ?? 0
                targetVC?.callBackFollowStatus = { followStatus in
                    let senderId = self.objNotificationVM.notificationArray[indexPath.row].sender ?? 0
                    for i in 0 ..< self.objNotificationVM.notificationArray.count {
                        if self.objNotificationVM.notificationArray[i].sender ?? 0 == senderId {
                            self.objNotificationVM.notificationArray[i].follow_status = followStatus
                        }
                    }
                    self.tblViewNotification.reloadData()
                }
                self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
            
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.notificationTableOtherCell) as? NotificationTableOtherCell
            cell?.notificationObject = objNotificationVM.notificationArray[indexPath.row]
            cell?.callBackPostImageClick = {
                let tag = self.objNotificationVM.notificationArray[indexPath.row].tag
                if tag == "order place" || tag == "Order Accept" {
                    let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderDetailVC) as? OrderDetailVC
                 targetVC?.isMyOrder =  tag == "order place" ? false : true
                    targetVC?.orderId = self.objNotificationVM.notificationArray[indexPath.row].order_id ?? 0
                    self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
                }
                    
                else {
                    let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.postDetailVC) as? PostDetailVC
                    targetVC?.postId = Int(self.objNotificationVM.notificationArray[indexPath.row].table_id ?? "0")
                    self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
                }
            }
            cell?.callBackTappedProfile = {
                let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
                targetVC?.isMyProfile = false
                targetVC?.passedUserId = self.objNotificationVM.notificationArray[indexPath.row].sender ?? 0
                self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

