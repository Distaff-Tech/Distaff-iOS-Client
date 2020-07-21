//
//  MyOrdersVM.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class MyOrdersVM {
    
    var ordersArray = [MyOrders(list: [MyOrderList(profilePic: #imageLiteral(resourceName: "DummyImage"), username: "Designed by Steve Smith", address: "Lorem ipsum dollar sit amet", price: "$2.50")], date: "Nov 12, 2019"),MyOrders(list: [MyOrderList(profilePic: #imageLiteral(resourceName: "DummyImage"), username: "Designed by John Shah", address: "Lorem ipsum dollar sit amet", price: "$1.50")], date: "Nov 15, 2019")]
    
    var myRequestPageNumber = 1
    var myOrdersPageNumber = 1
    var doesNxtPageExistMyRequest = false
    var doesNxtPageExistMyOrders = false
    
    var myRequestArray = [MyrequestListData?]()
    var myOrdersArray = [MyrequestListData?]()
    
    var isNeedToHitMyOrder = true
    var isNeedToHitMyRequest = true
    
    
    func callMyrequestListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping() -> Void) {
        let url = "\(WebServicesApi.my_request)page_num=\(myRequestPageNumber)"
        var localTimeZoneName: String { return TimeZone.current.identifier }
        Services.postRequest(url: url, param: [My_Requests.timeZone:localTimeZoneName], shouldAnimateHudd: shouldAnimate,refreshControl:refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(MyRequestModel.self, from: responseData)
                self.isNeedToHitMyRequest = false
                if self.myRequestPageNumber == 1 {
                    self.myRequestArray = data.response ?? []
                }
                else {
                    let dataObject = data.response ?? []
                    for i in 0..<dataObject.count {
                        if  self.myRequestArray.last??.date == dataObject[0].date && i == 0 {
                            let listToAppend = dataObject[0].list ?? []
                            for j in 0..<listToAppend.count  {
                                let newObject = listToAppend[j]
                                self.myRequestArray[self.myRequestArray.count - 1]?.list?.append(newObject)
                            }
                        }
                            
                        else {
                            let newObject = dataObject[i]
                            self.myRequestArray.append(newObject)
                        }
                        
                    }
                    
                }
                
                
                
                self.doesNxtPageExistMyRequest = data.has_next ?? false
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    func callMyOrderstListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping() -> Void) {
        let url = "\(WebServicesApi.past_orders)page_num=\(myOrdersPageNumber)"
        var localTimeZoneName: String { return TimeZone.current.identifier }
        Services.postRequest(url: url, param: [My_Requests.timeZone:localTimeZoneName], shouldAnimateHudd: shouldAnimate,refreshControl:refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(MyRequestModel.self, from: responseData)
                self.isNeedToHitMyOrder = false
                if self.myOrdersPageNumber == 1 {
                    self.myOrdersArray = data.response ?? []
                }
                else {
                    let dataObject = data.response ?? []
                    for i in 0..<dataObject.count {
                        if  self.myOrdersArray.last??.date == dataObject[0].date && i == 0 {
                            let listToAppend = dataObject[0].list ?? []
                            for j in 0..<listToAppend.count  {
                                let newObject = listToAppend[j]
                                self.myOrdersArray[self.myOrdersArray.count - 1]?.list?.append(newObject)
                            }
                        }
                            
                        else {
                            let newObject = dataObject[i]
                            self.myOrdersArray.append(newObject)
                        }
                        
                    }
                }
                
                self.doesNxtPageExistMyOrders = data.has_next ?? false
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
        
    }
    
    
    
    func callDeleteOrderApi(orderId:Int?,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.order_delete, param: [Delete_Order.order_id : orderId ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let _ = try JSONDecoder().decode(SignInModel.self, from: responseData)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
}

