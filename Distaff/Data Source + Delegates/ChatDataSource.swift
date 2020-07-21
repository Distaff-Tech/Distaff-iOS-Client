//
//  ChatDataSource.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser
import GrowingTextView

//MARK:TABLE DATA SOURCE(S)
extension ChatVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objChatVM.chatListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if objChatVM.chatListArray[indexPath.row].sender == (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.chatRightTableViewCell) as? ChatRightTableViewCell
            cell?.chatObject = objChatVM.chatListArray[indexPath.row]
            cell?.callBackProfileTapped = {
                self.dismissKeyboard()
                var images = [SKPhotoProtocol]()
                let photo = SKPhoto.photoWithImageURL("\(WebServicesApi.imageBaseUrl)\(self.objChatVM.chatListArray[indexPath.row].image ?? "")")
                photo.shouldCachePhotoURLImage = true
                images.append(photo)
                self.displayZoomImages(imageArray: images, index: 0)
            }
            return cell ?? UITableViewCell()
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.chatLeftTableViewCell) as? ChatLeftTableViewCell
            cell?.chatObject = objChatVM.chatListArray[indexPath.row]
            cell?.callBackProfileTapped = {
                self.dismissKeyboard()
                var images = [SKPhotoProtocol]()
                let photo = SKPhoto.photoWithImageURL("\(WebServicesApi.imageBaseUrl)\(self.objChatVM.chatListArray[indexPath.row].image ?? "")")
                photo.shouldCachePhotoURLImage = true
                images.append(photo)
                self.displayZoomImages(imageArray: images, index: 0)
            }
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK:- GROWING TEXT VIEW DELEGATE(S)
extension ChatVC: GrowingTextViewDelegate {
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
