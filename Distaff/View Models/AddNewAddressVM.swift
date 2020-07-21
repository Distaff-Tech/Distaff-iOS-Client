//
//  AddNewAddressVM.swift
//  Distaff
//
//  Created by netset on 23/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class AddNewAddressVM {
    
    
    
    
    func formValidations(_ request:AddNewAddress.Request) -> Bool {
        var message = ""
        if request.firstName?.whiteSpaceCount(text: request.firstName ?? "") == 0 {
            message = Messages.Validation.enterFirstName
        }
        else  if request.lastName?.whiteSpaceCount(text: request.lastName ?? "") == 0 {
            message = Messages.Validation.enterLastName
        }
            
        else  if request.mobileNumber?.whiteSpaceCount(text: request.mobileNumber ?? "") == 0 {
            message = Messages.Validation.enterMobile
        }
        else  if request.address?.whiteSpaceCount(text: request.address ?? "") == 0 {
            message = Messages.Validation.enterAddress
        }
            
        else  if request.city?.whiteSpaceCount(text: request.city ?? "") == 0 {
            message = Messages.Validation.enterCity
        }
            
        else  if request.postalCode?.whiteSpaceCount(text: request.postalCode ?? "") == 0 {
            message = Messages.Validation.enterPostalCode
        }
            
        else  if request.mobileNumber?.whiteSpaceCount(text: request.mobileNumber ?? "") ?? 0 < 8 {
            message = Messages.Validation.enterValidMobile
        }
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callAddAddressApi(_ request: AddNewAddress.Request,_completion:@escaping(_ data:AddressData?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.add_address, param: [Add_Address.first_name:request.firstName ?? "",Add_Address.last_name:request.lastName ?? "",Add_Address.phone : request.mobileNumber ?? "",Add_Address.address : request.address ?? "" ,Add_Address.city : request.city ?? "", Add_Address.postal_code : request.postalCode ?? ""], shouldAnimateHudd: true) { (responseData) in
                do {
                    let data = try JSONDecoder().decode(AddressData.self, from: responseData)
                    _completion(data)
                }
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}

