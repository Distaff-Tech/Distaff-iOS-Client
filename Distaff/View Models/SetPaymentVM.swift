//
//  SetPaymentVC.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class SetPaymentVM {
    
    func formValidations(_ request:AddCard.Request) -> Bool {
        var message = ""
        if request.cardNumber?.whiteSpaceCount(text: request.cardNumber ?? "") == 0 {
            message = Messages.Validation.enterCardNumber
        }
            
        else if request.name?.whiteSpaceCount(text: request.name ?? "") == 0 {
            message = Messages.Validation.enterCardName
        }
            
        else if request.expiryDate?.whiteSpaceCount(text: request.expiryDate ?? "") == 0 {
            message = Messages.Validation.enterExpiryDate
        }
            
            
        else if request.cvv?.whiteSpaceCount(text: request.cvv ?? "") == 0 {
            message = Messages.Validation.enterCvvNumber
        }
            
            
        else if request.cvv?.whiteSpaceCount(text: request.cvv ?? "") ?? 0 < 3 {
            message = Messages.Validation.enterValidCvv
        }
        else if request.cardNumber?.whiteSpaceCount(text: request.cardNumber ?? "") ?? 0 < 16 {
            message = Messages.Validation.enterValidCardNumber
        }
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callAddCardApi(_ request: AddCard.Request,_completion:@escaping(_ data:Cards?) -> Void) {
        if formValidations(request) {
            let expirayDate = (request.expiryDate ?? " / ").split(separator: "/")
            Services.postRequest(url: WebServicesApi.addCard, param: [Add_Card.cardNumber:request.cardNumber ?? "",Add_Card.expMonth:expirayDate[0] ,Add_Card.expYear : expirayDate[1],Add_Card.cvc :request.cvv ?? "",Add_Card.name:request.name ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let data = try JSONDecoder().decode(Cards.self, from: responseData)
                    _completion(data)
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}

