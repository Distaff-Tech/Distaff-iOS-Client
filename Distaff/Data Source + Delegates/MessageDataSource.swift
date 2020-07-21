//
//  MessageDataSource.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension MessageVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objVMMessage.recentMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.messageTableViewCell) as? MessageTableViewCell
        cell?.messageObject = objVMMessage.recentMessageList[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
        targetVC?.receiverId = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id == objVMMessage.recentMessageList[indexPath.row].sender_id ?? 0 ? objVMMessage.recentMessageList[indexPath.row].receiver_id ?? 0 :  objVMMessage.recentMessageList[indexPath.row].sender_id ?? 0
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title:nil, handler: { (action,view,completionHandler ) in
            
            let userName = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id == self.objVMMessage.recentMessageList[indexPath.row].sender_id ?? 0 ? self.objVMMessage.recentMessageList[indexPath.row].receiver_name ?? "" :  self.objVMMessage.recentMessageList[indexPath.row].sender_name ?? ""
            
            self.showAlertWithCancelAndOkAction(message: "\(Messages.DialogMessages.deleteEntireChat)\(" ")\(userName)", onComplete: {
                
                let request = DeleteChat.Request(receiverId: (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id == self.objVMMessage.recentMessageList[indexPath.row].sender_id ?? 0 ? self.objVMMessage.recentMessageList[indexPath.row].receiver_id ?? 0 :  self.objVMMessage.recentMessageList[indexPath.row].sender_id ?? 0, currentPage: self.calculateCurrentPage(index: indexPath.row + 1))
                
                self.objVMMessage.callDeleteChatApi(request) { (data) in
                    print(data)
                    self.objVMMessage.recentMessageList.remove(at: indexPath.row)
                    self.objVMMessage.totalPages = data.total_pages ?? 0
                    if data.data?.count != 0 {
                        let objectToAppend = data.data?[0]
                        let lastIndexId = data.deleted_message ?? 0
                        let lastIndex = self.objVMMessage.recentMessageList.firstIndex(where:{$0.id == lastIndexId})
                        print(lastIndex ?? 0)
                        self.objVMMessage.recentMessageList.insert(objectToAppend!, at: (lastIndex ?? self.objVMMessage.recentMessageList.count - 1) + 1 )
                        self.objVMMessage.recentMessageList =  self.objVMMessage.recentMessageList.uniques(by: \.id)
                    }
                    
                    tableView.reloadData()
                    self.tblViewMessage.showNoDataLabel(message:Messages.NoDataMessage.noChatList, arrayCount: self.objVMMessage.recentMessageList.count)
                }
                
            }) {
                self.tblViewMessage.isEditing = false
            }
            
        })
        action.image = UIImage(named: "delete")
        action.backgroundColor = AppColors.appColorBlue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == objVMMessage.recentMessageList.count - 1 && objVMMessage.pageNumber < objVMMessage.totalPages ?? 0 {
            self.objVMMessage.pageNumber =   objVMMessage.pageNumber + 1
            self.getRecentChatList(shouldAnimate: true)
        }
    }
    
}
