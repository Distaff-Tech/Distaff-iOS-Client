//
//  AddBankVM.swift
//  Distaff
//
//  Created by Aman on 02/06/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit


class AddBankVM {
    
    
    var accountTypeArray = ["Individual","Company"]
    
    
    func formValidations(_ request:AddBank.Request) -> Bool {
        var message = ""
        if request.acoountHolderName?.whiteSpaceCount(text: request.acoountHolderName ?? "") == 0 {
            message = Messages.Validation.enterActHolderName
        }
            
        else  if request.accountHolderType?.whiteSpaceCount(text: request.accountHolderType ?? "") == 0 {
            message = Messages.Validation.chooserActHolderType
        }
            
        else  if request.routingNumber?.whiteSpaceCount(text: request.routingNumber ?? "") == 0 {
            message = Messages.Validation.enterRoutingNumber
        }
            
        else  if request.bankAccountNumber?.whiteSpaceCount(text: request.bankAccountNumber ?? "") == 0 {
            message = Messages.Validation.enterActNumber
        }
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callAddBankApi(_ request: AddBank.Request,completion:@escaping(_ data:AddBankModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.addBank, param: [Add_Bank.accountHolderName:request.acoountHolderName ?? "",Add_Bank.accountType:request.accountHolderType ?? "",Add_Bank.routingNumber:request.routingNumber ?? "",Add_Bank.accountNumber:request.bankAccountNumber ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let data = try JSONDecoder().decode(AddBankModel.self, from: responseData)
                    completion(data)
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    
}
