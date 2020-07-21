//
//  CommentsVM.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class CommentsVM {
    
    
    var commentsArray = [commentArray]()
    var pageNumber = 1
    var doesNxtPageExist = false
    func formValidations(_ request:Comment.Request) -> Bool {
        var message = ""
        if request.comment?.whiteSpaceCount(text: request.comment ?? "") == 0 {
            message = Messages.Validation.enterComment
        }
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    func callCommentListApi(url:String,shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil,completion:@escaping() -> Void) {
        Services.getRequest(url: url, shouldAnimateHudd: shouldAnimateHudd, refreshControl: refreshControl) { (responseData) in
            
            do {
                let commentdata = try JSONDecoder().decode(CommentListModel.self, from: responseData)
                self.doesNxtPageExist = commentdata.has_next ?? false
                self.commentsArray = commentdata.data ?? []
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    func callSendCommentApi(_ request: Comment.Request,completion:@escaping() -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.postcomment, param: [Post_Comment.post_id:request.postId ?? "",Post_Comment.comment:request.comment?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let object = try JSONDecoder().decode(commentArray.self, from: responseData)
                    self.commentsArray.append(object)
                    completion()
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    func callDeleteCommentApi(_ request: DeleteComment.Request,completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.deleteComment, param: [Delete_Comment.comment:request.comment ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let _ = try JSONDecoder().decode(commentArray.self, from: responseData)
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    
}



