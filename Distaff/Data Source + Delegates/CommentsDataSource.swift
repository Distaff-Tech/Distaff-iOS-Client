//
//  CommentsDataSource.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import GrowingTextView

//MARK:TABLE DATA SOURCE(S)
extension CommentsVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objCommentsVM.commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.commentsTableViewCell) as? CommentsTableViewCell
        cell?.commentsObject = objCommentsVM.commentsArray[indexPath.row]
        cell?.callBackProfileTapped = {
            self.dismissKeyboard()
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
            targetVC?.isMyProfile = false
            targetVC?.passedUserId = self.objCommentsVM.commentsArray[indexPath.row].user ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo)?.id == objCommentsVM.commentsArray[indexPath.row].user ? true : false
    }
    
 
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .normal, title:nil, handler: { (action,view,completionHandler ) in
            self.objCommentsVM.callDeleteCommentApi(DeleteComment.Request(comment: self.objCommentsVM.commentsArray[indexPath.row].id)) {
                              self.objCommentsVM.commentsArray.remove(at: indexPath.row)
                              self.tblViewComments.showNoDataLabel(message: Messages.NoDataMessage.noCommentFound, arrayCount: self.objCommentsVM.commentsArray.count)
                              tableView.reloadData()
                          }
            })
        action.image = UIImage(named: "delete")
        action.backgroundColor = AppColors.appColorBlue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
        
        
    }
    
    
    
    
}

//MARK:- GROWING TEXT VIEW DELEGATE(S)
extension CommentsVC: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        if height > 150 {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        btnSend.alpha = textView.text.whiteSpaceCount(text: textView.text) > 0 ? 1.0 : 0.5
        btnSend.isUserInteractionEnabled = textView.text.whiteSpaceCount(text: textView.text) > 0 ? true : false
    }
}




