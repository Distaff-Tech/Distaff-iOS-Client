//
//  SettingsVM.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation

class SettingsVM {
    
    var settingsListingArray = [Settings(title:"My Favorites"),Settings(title:"My Cards"),Settings(title:"Change Password"),Settings(title:"Manage Bank"),Settings(title:"Terms and Conditions"),Settings(title:"Privacy Policies"),Settings(title:"Help and Support"),Settings(title:"Logout")]
    
    
    func callLogoutApi(_completion:@escaping(_ data:SignInModel?) -> Void) {
        Services.getRequest(url: WebServicesApi.logout, shouldAnimateHudd: true) { (responseData) in
            do {
                let logoutData = try JSONDecoder().decode(SignInModel.self, from: responseData)
                _completion(logoutData)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    func callNotificationToggleApi(_ notificationStatus:Int,_completion:@escaping(_ data:SignInModel?) -> Void) {
        Services.postRequest(url: WebServicesApi.set_onOffNotification, param: [Notification_Toggle.notificationStatus:notificationStatus], shouldAnimateHudd: true) { (responseData) in
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
