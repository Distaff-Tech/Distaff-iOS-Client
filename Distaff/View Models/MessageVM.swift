//
//  MessageVM.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class MessageVM {
    
    var recentMessageList = [chatHistoryData]()
    var pageNumber = 1
    var totalPages:Int?
    var hasLoadChatData = false
    
    func callRecentChatListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping(ChatHistoryModel) -> Void) {
        let url = "\(WebServicesApi.chat_history)page_num=\(pageNumber)"
        Services.getRequest(url: url, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(ChatHistoryModel.self, from: responseData)
                self.totalPages = data.total_pages ?? 0
                self.recentMessageList = self.pageNumber == 1 ? data.data ?? [] :  self.recentMessageList + (data.data ?? [])
                self.hasLoadChatData = true
                _completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    func callDeleteChatApi(_ request: DeleteChat.Request,completion:@escaping(ChatHistoryModel) -> Void) {
        Services.postRequest(url: WebServicesApi.delete_message, param: [Delete_ChatHistory.receiver_id : request.receiverId ?? 0,Delete_ChatHistory.page_num:request.currentPage ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(ChatHistoryModel.self, from: responseData)
                completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
}
