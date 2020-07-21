//
//  OrderDetailVM.swift
//  Distaff
//
//  Created by Aman on 25/03/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class OrderDetailVM {
    
    var orderDetailData:OrderDetailData?
    
    func callOrderdetailApi(ref:OrderDetailVC,_ request: OrderDetail.Request) {
        Services.postRequest(url: WebServicesApi.orderDetail, param: [Order_Detail.order_id:request.order_id ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(OrderDetailModel.self, from: responseData)
                self.orderDetailData = data.data
                self.displayOrderdetaildatya(ref: ref, data: data.data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    func displayOrderdetaildatya(ref:OrderDetailVC,data:OrderDetailData?) {
        ref.postImage.setSdWebImage(url: data?.post_images ?? "")
        ref.lblSize.text = "\("Size: ")\(data?.size_name ?? "")"
        ref.lblColor.text = "\("Color: ")\(data?.colour_name ?? "")"
        ref.lblTime.text =  CommonMethods.convertDateFormat(inputFormat: "yyyy-MM-dd", outputFormat: "MMM dd, yyyy", dateString: data?.date ?? "" )
        ref.lblDescription.text = data?.post_description ?? ""
        ref.profilePic.setSdWebImage(url: ref.isMyOrder ? data?.design_by_image ?? "" : data?.order_by_image ?? "" )
        ref.lblUserName.text = ref.isMyOrder ? data?.design_by ?? "" : data?.order_by ?? ""
        if ref.isMyOrder {
            let price = Double(data?.price ?? "0.00") ?? 0.00
            let servicePrice = ((price * (data?.serviceCharge ?? 0.0) ) / 100).truncate(places: 2)
            let totalPrice = (price + servicePrice).calculateCurrency(fractionDigits: 2)
            ref.lblPrice.text = "$\(totalPrice)"
            // show Address
            if data?.address?.count ?? 0 > 0 {
                let object =  data?.address?[0]
                ref.lblAddress.text = "\(object?.address ?? "")\(", \(object?.city ?? "")")\(", \(object?.postal_code ?? "")")"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let createdDate = dateFormatter.date(from: data?.created_time ?? "")
            if let date = createdDate {
                let hourDiffrence = Date().hours(from: date)
                ref.cancelOrderView.isHidden = (hourDiffrence < 1 && data?.order_status == 0) ? false  : true
                ref.stackViewcancelPolicy.isHidden = ref.cancelOrderView.isHidden
            }
            
            ref.lblOrderStatus.isHidden = data?.order_status != 0 ? false  : true
            ref.lblOrderStatus.text = data?.order_status == 1 ? "\("Accepted by ")\(data?.design_by ?? "")" : data?.order_status == 2 ? "\("Declined by ")\(data?.design_by ?? "")" : "Cancelled by you"
            ref.lblOrderStatus.textColor = data?.order_status == 1 ? AppColors.appColorBlue : .red
        }
        else {
            ref.lblPrice.text = "\("$")\(data?.price ?? "0")"
            ref.lblOrderStatus.isHidden = true
            ref.lblAddress.text  = data?.design_by_address ?? ""
            ref.bottomAnchor.constant =  -120.0
        }
        ref.stackviewAcceptdeclined.isHidden = data?.order_status == 0 ? false : true
        ref.lblAcceptedrejected.isHidden = !ref.stackviewAcceptdeclined.isHidden
        ref.stackAcceptrejectHeight.constant = data?.order_status == 0 ? 45 : 0
        ref.lblAcceptedrejected.text = data?.order_status == 1 ? "Accepted" : "Declined"
        ref.lblAcceptedrejected.backgroundColor = data?.order_status == 1 ? AppColors.appColorBlue : .red
        
        
        
    }
    
    func callCancelOrderApi(request: CancelOrder.Request,completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.cancelOrder, param: [Cancel_Order.order_id:request.order_id ?? 0,Cancel_Order.order_status :request.orderStatus ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                self.orderDetailData?.order_status = -2
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
}
