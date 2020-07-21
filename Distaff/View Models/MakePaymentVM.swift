//
//  MakePaymentVM.swift
//  Distaff
//
//  Created by netset on 02/03/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit


class MakePaymentVM {
    
    
    
    func formValidations(_ request:MakePayment.Request) -> Bool {
        //         var message = ""
        //        if request.cvv?.whiteSpaceCount(text: request.cvv ?? "") == 0 {
        //             message = Messages.Validation.enterCvvNumber
        //         }
        //        else  if request.cvv?.count ?? 0 < 3 {
        //             message = Messages.Validation.enterValidCvv
        //         }
        //
        //         else {
        //             return true
        //         }
        //         if message != "" {
        //             Alert.displayAlertOnWindow(with: message)
        //         }
        return false
    }
    
    
    func callMakePaymentApi(_ request: MakePayment.Request,_completion:@escaping() -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.order_create, param: [Make_Payment.card:request.cardId ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                    _completion()
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
        
    }
    
}
