//
//  HelpAndSupportVM.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation

class HelpAndSupportVM {
    
    
    func formValidations(_ request:HelpAndSupport.Request) -> Bool {
        var message = ""
        if request.name?.whiteSpaceCount(text: request.name ?? "") == 0 {
            message = Messages.Validation.enterName
        }
            
        else if request.email?.whiteSpaceCount(text: request.email ?? "") == 0 {
            message = Messages.Validation.enterEmail
        }
            
        else if request.subject?.whiteSpaceCount(text: request.subject ?? "") == 0 {
            message = Messages.Validation.enterSubject
        }
        else if request.message?.whiteSpaceCount(text: request.message ?? "") == 0 {
            message = Messages.Validation.enterMessage
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
    
    
    
    func callContactUsApi(_ request: HelpAndSupport.Request,_completion:@escaping(_ data:SignInModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.contactUs, param: [Contact_Us.fullname:request.name ?? "",Contact_Us.email:request.email ?? "",Contact_Us.subject : request.subject ?? "",Contact_Us.message : request.message ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let signInData = try JSONDecoder().decode(SignInModel.self, from: responseData)
                    _completion(signInData)
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
}
