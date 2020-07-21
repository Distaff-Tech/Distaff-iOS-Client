//
//  ForgotPasswordVM.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation

class ForgotPasswordVM {
    
    func formValidations(_ request:ForgotPassword.Request) -> Bool {
        var message = ""
        if request.email?.whiteSpaceCount(text: request.email ?? "") == 0 {
            message = Messages.Validation.enterEmail
        }
        else if !((request.email?.validateEmail(candidate: request.email ?? ""))!) {
            message = Messages.Validation.enterCorrectEmail
        }
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    func callForgotPasswordApi(_ request: ForgotPassword.Request,_completion:@escaping(_ data:SignUpModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.forgotPassword, param: [Forgot_Password.email:request.email ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let SignUpData = try JSONDecoder().decode(SignUpModel.self, from: responseData)
                    _completion(SignUpData)
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}
