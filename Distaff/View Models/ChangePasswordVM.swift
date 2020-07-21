//
//  ChangePasswordVM.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation


class ChangePasswordVM {
    
    func formValidations(_ request:ChangePassword.Request) -> Bool {
        var message = ""
        if request.currentPassword?.isEmpty ?? false {
            message = Messages.Validation.enterCurrentPassword
        }
            
        else if request.newPassword?.isEmpty ?? false {
            message = Messages.Validation.enterNewPassword
        }
            
        else if request.confirmPassword?.isEmpty ?? false {
            message = Messages.Validation.enterConfirmPassword
        }
            
        else if request.newPassword?.count ?? 0 < 8 {
            message = Messages.Validation.enterValidPassword
        }
            
        else if request.newPassword != request.confirmPassword {
            message = Messages.Validation.oldPasswordDoesNotMatch
        }
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callChangePasswordApi(_ request: ChangePassword.Request,_completion:@escaping(_ data:SignInModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.changePassword, param: [Change_Password.currentPassword:request.currentPassword ?? "",Change_Password.newPassword:request.newPassword ?? ""], shouldAnimateHudd: true) { (responseData) in
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
