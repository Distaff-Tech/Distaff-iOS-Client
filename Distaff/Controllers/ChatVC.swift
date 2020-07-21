//
//  ChatVC.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import GrowingTextView

class ChatVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var messageBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var tblViewChat: UITableView!
    @IBOutlet weak var txtViewMessage: GrowingTextView!
    @IBOutlet weak var btnSend: UIButton!
    
    //MARK:VARIABLE(S)
    let objChatVM = ChatVM()
    var receiverId:Int?
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        enableIQKeyboard()
        removeAllObserversAdded()
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 40) {
            print("up")
            if txtViewMessage.isEditable {
                dismissKeyboard()
            }
        }
        
    }
    
    
    
    
    override func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            messageBottomAnchor.constant = 7
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
                self.view.setNeedsLayout()
            })
        }
    }
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            messageBottomAnchor.constant = keyboardSize.height + 7
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
                self.view.setNeedsLayout()
            })
        }
        
    }
    
    
    override func refreshData() {
        objChatVM.callGetChatListsApi(receiverId: receiverId, refreshControl: refreshControl, shouldAnimate: false) {
            self.tblViewChat.reloadData()
            self.tblViewChat.showNoDataLabel(message:Messages.NoDataMessage.noMessage, arrayCount: self.objChatVM.chatListArray.count)
            if self.objChatVM.chatListArray.count > 0 {
                self.tblViewChat.scrollToBottom(indexPath:NSIndexPath(row: self.objChatVM.chatListArray.count - 1, section: 0))
            }
            
        }
        
    }
    
    
    
}
//MARK:ALL METHOD(S)
extension ChatVC {
    func prepareUI() {
        self.tblViewChat.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0);
        handleTabbarVisibility(shouldHide: true)
        txtViewMessage.setPlaceholder(with: "Write Your Message", placeholderColor:#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1))
        disableIQKeyboard()
        addKeyBoardObservers()
        addRefreshControlInTable(tableView: self.tblViewChat)
        
        objChatVM.callGetChatListsApi(receiverId: receiverId, shouldAnimate: true) {
            self.tblViewChat.reloadData()
            self.tblViewChat.showNoDataLabel(message:Messages.NoDataMessage.noMessage, arrayCount: self.objChatVM.chatListArray.count)
            if self.objChatVM.chatListArray.count > 0 {
                self.tblViewChat.scrollToBottom(indexPath:NSIndexPath(row: self.objChatVM.chatListArray.count - 1, section: 0))
            }
            
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refreshChatList),
            name:NSNotification.Name(rawValue:NotificationObservers.refreshChatList),
            object: nil)
        
    }
    
    @objc  func refreshChatList(notification: NSNotification){
        let userInfo  = notification.userInfo
        if receiverId == Int(userInfo?["sender_id"] as? String ?? "0") {
            objChatVM.callGetChatListsApi(receiverId: receiverId, shouldAnimate: false) {
                self.tblViewChat.reloadData()
                self.tblViewChat.showNoDataLabel(message:Messages.NoDataMessage.noMessage, arrayCount: self.objChatVM.chatListArray.count)
                if self.objChatVM.chatListArray.count > 0 {
                    self.tblViewChat.scrollToBottom(indexPath:NSIndexPath(row: self.objChatVM.chatListArray.count - 1, section: 0))
                }
                
            }
        }
        
    }
    
    
}
//MARK:ALL ACTION(S)
extension ChatVC {
    @IBAction func didTappedSend(_ sender: UIButton) {
        objChatVM.callSendMessageApi(Message.Request(message: CommonMethods.encode(txtViewMessage.text), receiver_id: receiverId), shouldAnimate: true) {
            self.txtViewMessage.text = ""
            self.btnSend.alpha =  0.5
            self.btnSend.isUserInteractionEnabled = false
            self.tblViewChat.reloadData()
            self.tblViewChat.showNoDataLabel(message:Messages.NoDataMessage.noMessage, arrayCount: self.objChatVM.chatListArray.count)
            if self.objChatVM.chatListArray.count > 0 {
                self.tblViewChat.scrollToBottom(indexPath:NSIndexPath(row: self.objChatVM.chatListArray.count - 1, section: 0))
            }
        }
        
    }
    @IBAction func didTappedBack(_ sender: UIButton) {
        dismissKeyboard()
        PopViewController()
        
    }
    
}
