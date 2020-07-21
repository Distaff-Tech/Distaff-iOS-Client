//
//  CommentsVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import GrowingTextView

class CommentsVC: BaseClass {
    
    
    var callBackCommentCount: ((_ totalComment:Int)->())?
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewComments: UITableView!
    @IBOutlet weak var commentViewBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var txtViewMessage: GrowingTextView!
    @IBOutlet weak var btnSend: UIButton!
    
    
   //MARK:VARIABLE(S)
    let objCommentsVM = CommentsVM()
    var postId:Int?
    
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
            if txtViewMessage.isEditable {
                dismissKeyboard()
            }
        }
        
    }
    
    
    override func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            commentViewBottomAnchor.constant = 7
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
                self.view.setNeedsLayout()
            })
        }
        
    }
    
    
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            commentViewBottomAnchor.constant = keyboardSize.height + 7
            UIView.animate(withDuration: 1.0, animations: {
                self.view.layoutIfNeeded()
                self.view.setNeedsLayout()
            })
        }
        
    }
    
    override func refreshData() {
        fetchCommentList(refreshControl: refreshControl, shouldAnimate: false)
        
    }
    
}

//MARK:ALL METHODS(S)
extension CommentsVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        tblViewComments.removeExtraSeprators()
        addRefreshControlInTable(tableView: self.tblViewComments)
        txtViewMessage.setPlaceholder(with: "Write Your Comment Here", placeholderColor:#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1))
        disableIQKeyboard()
        addKeyBoardObservers()
        fetchCommentList(shouldAnimate: true)
        
    }
    
    func fetchCommentList(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool) {
        let url = "\(WebServicesApi.getcomment)\(postId ?? 0)"
        objCommentsVM.callCommentListApi(url: url, shouldAnimateHudd: shouldAnimate,refreshControl:refreshControl) {
            self.tblViewComments.reloadData()
            self.tblViewComments.showNoDataLabel(message: Messages.NoDataMessage.noCommentFound, arrayCount: self.objCommentsVM.commentsArray.count)
            if self.objCommentsVM.commentsArray.count > 0 {
                self.tblViewComments.scrollToBottom(indexPath:NSIndexPath(row: self.objCommentsVM.commentsArray.count - 1, section: 0))
            }
        }
    }
    
}


//MARK:ALL ACTION(S)
extension CommentsVC {
    @IBAction func didTappedSend(_ sender: UIButton) {
        objCommentsVM.callSendCommentApi(Comment.Request(comment:CommonMethods.encode(txtViewMessage.text), postId: postId ?? 0)) {
            self.txtViewMessage.text = ""
            self.btnSend.isUserInteractionEnabled = false
            self.btnSend.alpha = 0.5
            self.tblViewComments.reloadData()
             self.tblViewComments.showNoDataLabel(message: Messages.NoDataMessage.noCommentFound, arrayCount: self.objCommentsVM.commentsArray.count)
            if self.objCommentsVM.commentsArray.count > 0 {
                self.tblViewComments.scrollToBottom(indexPath:NSIndexPath(row: self.objCommentsVM.commentsArray.count - 1, section: 0))
            }
            
        }
        
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        self.callBackCommentCount?(self.objCommentsVM.commentsArray.count)
        PopViewController()
    }
    
}

