//
//  SignUpVM.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation

class SignUpVM {
    
    func formValidations(_ request:SignUP.Request) -> Bool {
        var message = ""
        if request.email?.whiteSpaceCount(text: request.email ?? "") == 0 {
            message = Messages.Validation.enterEmail
        }
            
        else if request.password?.isEmpty ?? false {
            message = Messages.Validation.enterPassword
        }
            
        else if request.confirmPassword?.isEmpty ?? false {
            message = Messages.Validation.enterConfirmPassword
        }
        else if request.password != request.confirmPassword {
            message = Messages.Validation.passwordDoesNotMatch
        }
            
        else if request.password?.count ?? 0 < 8 {
            message = Messages.Validation.enterValidPassword
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
    
    
    func callSignUpApi(_ request: SignUP.Request,_completion:@escaping(_ data:SignUpModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.signUp, param: [Sign_Up.email:request.email ?? "",Sign_Up.phone :request.phoneNumber ?? "",Sign_Up.password:request.password ?? "",Sign_Up.deviceId:userdefaultsRef.value(forKey: UserDefaultsKeys.deviceId) as? String ?? "No Token",Sign_Up.deviceType:AppInfo.deveiceType], shouldAnimateHudd: true) { (responseData) in
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
