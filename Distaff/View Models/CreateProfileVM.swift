//
//  CreateProfileVM.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
class CreateProfileVM : NSObject {
    
    var capturedImage:UIImage? = nil
    
    func formValidations(_ request:CreateProfile.Request) -> Bool {
        var message = ""
        if request.isFirstPage ?? false {
            if request.isFromEditProfile == 0 && request.profilePicture == nil {
                message = Messages.Validation.chooseProfilePic
                
            }
                
            else    if request.userName?.whiteSpaceCount(text: request.userName ?? "") == 0 {
                message = Messages.Validation.enterUserName
            }
            else  if request.fullName?.whiteSpaceCount(text: request.fullName ?? "") == 0 {
                message = Messages.Validation.enterFullName
            }
                
            else  if request.completeAddress?.whiteSpaceCount(text: request.completeAddress ?? "") == 0 {
                message = Messages.Validation.enterCompleteAddress
            }
            else {
                return true
            }
        }
        else {
            
            if request.DateOfBirth?.whiteSpaceCount(text: request.DateOfBirth ?? "") == 0 {
                message = Messages.Validation.enterDOB
            }
            else  if request.about?.whiteSpaceCount(text: request.about ?? "") == 0 {
                message = Messages.Validation.enterAboutMe
            }
                
            else {
                return true
            }
            
            
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    func callCreateProfileApi(_ request: CreateProfile.Request,_completion:@escaping(_ data:CreateProfileModel?) -> Void) {
        if formValidations(request) {
            let dict = [Create_Profile.address:request.completeAddress ?? "",Create_Profile.aboutMe : request.about ?? "" ,Create_Profile.gender : request.gender ?? "",Create_Profile.dob:CommonMethods.convertDateFormat(inputFormat: "MM-dd-yyyy", outputFormat: "yyyy-MM-dd", dateString: request.DateOfBirth ?? ""),Create_Profile.fullName : request.fullName ?? "",Create_Profile.userName : request.userName ?? "",Create_Profile.is_from_edit : request.isFromEditProfile ?? false] as [String : Any] 
            let param = [Create_Profile.data:CommonMethods.convertDictToJsonString(dictionary: dict)]
            Services.postRequestWithImage(imageName: Create_Profile.image, url: WebServicesApi.createProfile, shouldAnimateHudd: true, param:param , image: request.profilePicture) { (responseData) in
                do {
                    let createProfileData = try JSONDecoder().decode(CreateProfileModel.self, from: responseData)
                    _completion(createProfileData)
                }
                    
                catch {
                    Alert.displayAlertOnWindow(with: error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
