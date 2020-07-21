//
//  SelectPaymentVM.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class SelectPaymentVM {
    
    var cardListArray = [Cards]()
    var selectedIndex = -1
    
    
    func callMakePaymentApi(_ request: MakePayment.Request,_completion:@escaping() -> Void) {
        
        Services.postRequest(url: WebServicesApi.order_create, param: [Make_Payment.card:request.cardId ?? "",Make_Payment.amt:request.amount ?? "",Make_Payment.address_id : request.addressId ?? 0], shouldAnimateHudd: true) { (responseData) in
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

