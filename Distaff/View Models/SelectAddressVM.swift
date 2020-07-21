//
//  SelectAddressVM.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
class SelectAdddressVM {
    
    var addressListArray = [AddressData]()
    
    func callGetAddressListApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping() -> Void) {
        Services.getRequest(url: WebServicesApi.get_address, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(AddressListModel.self, from: responseData)
                self.addressListArray = data.data ?? []
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    
    func callDeleteAddressApi(addressId:Int,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.delete_address, param: [Delete_Address.address:addressId], shouldAnimateHudd: true) { (responseData) in
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


