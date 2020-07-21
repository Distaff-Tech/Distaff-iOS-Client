//
//  AddPostVM.swift
//  Distaff
//
//  Created by netset on 10/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class AddPostVM{
    
    var definedMinimumPrice:Double?
    func formValidations(_ request:AddPost.Request) -> Bool {
        var message = ""
        let price  = Double(request.price ?? "0.00") ?? 0.00
        
        if request.price?.whiteSpaceCount(text: request.price ?? "") == 0 {
            message = Messages.Validation.enterPrice
        }
        else if price < definedMinimumPrice ?? 10.00  {
            let doubleStr = String(format: "%.2f", definedMinimumPrice ?? 0.0)
            message = "price must be greater than or equal to minimum price which is $\(doubleStr )"
        }
        else  if request.description?.whiteSpaceCount(text: request.description ?? "") == 0 {
            message = Messages.Validation.enterAboutMe
        }
            
        else  if request.clothMaterial?.count == 0 {
            message = Messages.Validation.chooseClothMaterial
        }
        else  if request.sizesAvailable?.count == 0 {
            message = Messages.Validation.chooseClothSizes
        }

        else if Variables.shared.imageColorArray.count == 0 {
            message = Messages.Validation.chooseColorScheme
        }
            
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
    
    func callGetSize_ColorListApi(_completion:@escaping(_ data:Fabric_Size_Model?) -> Void) {
        Services.getRequest(url: WebServicesApi.get_colour_size, shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(Fabric_Size_Model.self, from: responseData)
                self.definedMinimumPrice = data.minimumPrice ?? 10.00
                Variables.shared.sizeListArray = data.size ?? []
                Variables.shared.fabricListArray = data.fabric ?? []
                Variables.shared.colorListArray = data.colour ?? []
                _completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    func callAddPostApi(_ request: AddPost.Request,_completion:@escaping(_ data:CreateProfileModel?) -> Void) {
        if formValidations(request) {
            let colorIdArray = Variables.shared.imageColorArray.compactMap{(($0.colorId))}
            let imagesArray = Variables.shared.imageColorArray.compactMap{(($0.image))}
            
            let dict = [Add_Post.price:request.price ?? "0",Add_Post.postDescription:request.description ?? "",Add_Post.fabric:request.clothMaterial ?? "",Add_Post.size:request.sizesAvailable ?? "",Add_Post.colour:colorIdArray] as [String : Any]
            let param = [Add_Post.data:CommonMethods.convertDictToJsonString(dictionary: dict)]
            print(param)
            
            Services.postRequestWithMultipleImages(imageName: Add_Post.post_images, url: WebServicesApi.addpost, shouldAnimateHudd: true, param: param, images: imagesArray) { (responseData) in
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


