//
//  ShoppingBagVM.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class ShoppingBagVM {
    
    
    var shoppingBagItems = [ShoppingBagData]()
    var isAddressChoosen = false
    var addressObject : AddressData?
    var serviceCharge:Double?
    
    func callGetShoppingBagListApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,completion:@escaping() -> Void) {
        Services.getRequest(url: WebServicesApi.get_cart_posts, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(ShoppingBagModel.self, from: responseData)
                self.shoppingBagItems = data.data ?? []
                self.isAddressChoosen = data.default_address ?? false
                self.addressObject = data.address_name
                self.serviceCharge = data.serviceCharge ?? 0.0
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    func callDeleteItemFromCart(cartId:Int,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.delete_cart_post, param: [Delete_Cart.cart_id:cartId], shouldAnimateHudd: true) { (responseData) in
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
