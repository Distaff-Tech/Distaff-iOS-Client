//
//  ChatVM.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class ChatVM {
    
    var chatListArray = [ChatData]()
    
    func formValidations(_ request:Message.Request) -> Bool {
        var message = ""
        if request.message?.whiteSpaceCount(text: request.message ?? "") == 0 {
            message = Messages.Validation.enterMessage
        }
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callGetChatListsApi(receiverId:Int? ,refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool, completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.get_message, param: [Get_message.id:receiverId ?? 0], shouldAnimateHudd: shouldAnimate,refreshControl:refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(ChatListModel.self, from: responseData)
                self.chatListArray = data.data ?? []
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    
    func callSendMessageApi(_ request: Message.Request,shouldAnimate:Bool, completion:@escaping() -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.send_message, param: [Send_message.message:request.message ?? "",Send_message.receiver_id:request.receiver_id ?? 0], shouldAnimateHudd: true) { (responseData) in
                do {
                    let data = try JSONDecoder().decode(ChatData.self, from: responseData)
                    self.chatListArray.append(data)
                    completion()
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}

