//
//  OrderDetailVC.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class OrderDetailVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var lblOrderBy: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var acceptDeclineView: UIView!
    @IBOutlet weak var canOrderBtneightAnchor: NSLayoutConstraint!
    @IBOutlet weak var cancellationPolicyHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var acceptDeclineHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var cancelOrderView: UIView!
    @IBOutlet weak var cancelOrderHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var cancelPolicyStackView: UIStackView!
    @IBOutlet weak var cancelPolicyTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var stackviewAcceptdeclined: UIStackView!
    @IBOutlet weak var lblAcceptedrejected: UILabel!
    @IBOutlet weak var stackAcceptrejectHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelPolicyView: UIView!
    @IBOutlet weak var cancelPolicyheightAnchot: NSLayoutConstraint!
    @IBOutlet weak var stackViewcancelPolicy: UIStackView!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var bottomAnchor: NSLayoutConstraint!
    
    
    //MARK:VARIABLE(S)
    var isMyOrder = false
    var orderId:Int?
    var objVM = OrderDetailVM()
    
    var callBackAccepted : (() -> ())?
    var callBackDeclined : (() -> ())?
    var callBackCancelled : (() -> ())?
    
    //MARK:ALL METHOD(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        removeAllObserversAdded()
    }
    
    @IBAction func didtappedDecline(_ sender: UIButton) {
        CommonMethods.callAcceptRejectOrderApi(order_id:objVM.orderDetailData?.id ?? 0, order_status: false) {
            self.stackviewAcceptdeclined.isHidden = true
            self.lblAcceptedrejected.isHidden = false
            self.stackAcceptrejectHeight.constant = 0
            self.lblAcceptedrejected.text = "Declined"
            self.lblAcceptedrejected.backgroundColor = .red
            self.callBackDeclined?()
        }
        
    }
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
             let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
             targetVC?.isMyProfile = false
        targetVC?.passedUserId = objVM.orderDetailData?.message_id ?? 0
             self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    @IBAction func didtappedAccept(_ sender: UIButton) {
        CommonMethods.callAcceptRejectOrderApi(order_id:objVM.orderDetailData?.id ?? 0, order_status: true) {
            self.stackviewAcceptdeclined.isHidden = true
            self.lblAcceptedrejected.isHidden = false
            self.stackAcceptrejectHeight.constant = 0
            self.lblAcceptedrejected.text = "Accepted"
            self.lblAcceptedrejected.backgroundColor = AppColors.appColorBlue
            
            self.callBackAccepted?()
        }
    }
}

//MARK:ALL ACTION(S)
extension OrderDetailVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    @IBAction func didPressOrderSummary(_ sender: UIButton) {
        if let summaryObject = objVM.orderDetailData  {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderSummaryVC) as? OrderSummaryVC
        targetVC?.orderSummaryData = summaryObject
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
    }
    
    @IBAction func didPressCancelPolicy(_ sender: UIButton) {
        let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.webVC) as? WebVC
        targetVC?.webViewData = WebView(title: "CANCELLATION POLICY", url:WebUrlLinks.cancellationPolicy)
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        
    }
    
    @IBAction func didPressCancelOrder(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let createdDate = dateFormatter.date(from: objVM.orderDetailData?.created_time ?? "")
        if let date = createdDate {
        let hourDiffrence = Date().hours(from: date)
            if hourDiffrence < 1 {
                objVM.callCancelOrderApi(request:CancelOrder.Request(order_id: objVM.orderDetailData?.id ?? 0, orderStatus: -2)) {
                self.lblOrderStatus.isHidden = false
                    self.lblOrderStatus.text =  "Cancelled by you"
                               self.lblOrderStatus.textColor =  .red
                    self.stackViewcancelPolicy.isHidden = true
                    self.cancelOrderView.isHidden = true
                    self.callBackCancelled?()
                }
            }
            else {
                self.showAlert(message: "you can not cancel this order now.")
            }
        }
    }
    
    @IBAction func didTappedMessage(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
        targetVC?.receiverId = objVM.orderDetailData?.message_id ?? 0
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    @IBAction func didTappedOptionMenu(_ sender: UIButton) {
        CommonMethods.reportPostOptions { (text) in
            CommonMethods.callReportPostApi(postId:self.objVM.orderDetailData?.post ?? 0 , reason: text) {
                self.showAlert(message: "Post has been reported successfully.")
            }
            
        }
        
    }
    @IBAction func didTappedPostImage(_ sender: UIButton) {
        displayZoomSingleImages(url: objVM.orderDetailData?.post_images ?? "")
        
    }
}

//MARK:ALL METHOD(S)
extension OrderDetailVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        getOrderDetail()
        if !isMyOrder {
           // cancellationPolicyHeightAnchor.constant = 0.0
            cancelPolicyStackView.isHidden = true
        }
        else {
            acceptDeclineHeightAnchor.constant = 0.0
            acceptDeclineView.isHidden = true
            cancelPolicyTopAnchor.constant = 0.0
        }
        lblOrderBy.text = isMyOrder != true ? "ORDER BY" :"DESIGN BY"
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.refreshOrderDetail),
        name:NSNotification.Name(rawValue: NotificationObservers.refreshOrderDetail),
        object: nil)
        
    }
    
    @objc  func refreshOrderDetail(notification: NSNotification){
        
        let userInfo  = notification.userInfo
        if orderId == Int(userInfo?["order_id"] as? String ?? "0") {
          getOrderDetail()
        }
       }
    
    
    
    func getOrderDetail() {
        objVM.callOrderdetailApi(ref:self,OrderDetail.Request(order_id: orderId ?? 0))
    }
    
    
}
