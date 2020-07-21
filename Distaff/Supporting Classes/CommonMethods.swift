//
//  CommonMethods.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications



class CommonMethods: NSObject {
    class func makeInitialRoot() {
        if let data = userdefaultsRef.value(forKey: UserDefaultsKeys.isUserLogedIn) {
            print(data)
            self.setRoot(VC: homeStoryBoard.instantiateViewController(withIdentifier:ViewControllersIdentifers.tabbarVC))
        }
        else {
            self.setRoot(VC: loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.initialNavigation))
        }
    }
    
    
    class func convertDateFormat(inputFormat:String,outputFormat:String,dateString:String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        let showDate = inputFormatter.date(from:dateString)
        inputFormatter.dateFormat = outputFormat
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
        
    }
    
    class func clrAllRemoteNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        center.removeAllPendingNotificationRequests()
        
    }
    
    
    
    class  func setRoot(VC:UIViewController) {
        appDelegateRef.window?.rootViewController = VC
        appDelegateRef.window?.makeKeyAndVisible()
        
        if VC.isKind(of: TabbarVC.self) {
            Variables.shared.shouldLoadPostData = true
            Variables.shared.shouldLoadProfileData = true
            Variables.shared.hasPendingNotifications = false
        }
        else {
            userdefaultsRef.removeObject(forKey: UserDefaultsKeys.isUserLogedIn)
            userdefaultsRef.removeObject(forKey: UserDefaultsKeys.bankInfo)
            
        }
        UIView.transition(with: appDelegateRef.window ?? UIView(),
                          duration: 0.5,
                          options: VC.isKind(of: TabbarVC.self) == true ?.transitionFlipFromRight : .transitionFlipFromLeft,
                          animations: nil,
                          completion: nil)
        
        
    }
    
    
    class func reportPostOptions(onTapped: @escaping((_ title:String)->())) {
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Unauthorized Sales", style: .default, handler: { (action) in
            onTapped("Unauthorized Sales")
        }))
        
        
        sheet.addAction(UIAlertAction(title: "Inappropriate content", style: .default, handler: { (action) in
            onTapped("Inappropriate content")
        }))
        
        sheet.addAction(UIAlertAction(title: "Threatening or violent", style: .default, handler: { (action) in
            onTapped("Threatening or violent")
        }))
        
        sheet.addAction(UIAlertAction(title: "Others", style: .default, handler: { (action) in
            onTapped("Others")
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
            
        }))
        
        
        sheet.view.tintColor = AppColors.appColorBlue
        appDelegateRef.window?.rootViewController?.present(sheet, animated: true, completion: nil)
    }
    
    
    class func convertDictToJsonString(dictionary:[String:Any]) -> String {
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return theJSONText
        }
        return ""
    }
    
    
    
    class func handleSessionExpire(message:String) {
        Alert.displayAlertOnWindowWithOkAction(message: message) {
            CommonMethods.setRoot(VC: loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.initialNavigation))
        }
        
    }
    
    
  class  func newVersionExist()  {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let alert = UIAlertController(title: AppInfo.appName, message: "An updated version  of App is available.Please update your application.", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Update", style: .default) { (UIAlertAction) in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(AppInfo.appStoreId)"),
                UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    alert.view.tintColor = AppColors.appColorBlue
        alert.addAction(okBtn)
        appDel.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    class func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    
    
    class func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "a minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    
    class func dateAndTimeFormat(utcDate:String) -> Date?{
        if utcDate.count == 0{
            return nil
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            let dt = dateFormatter.date(from: utcDate)
            //dateFormatter.dateFormat = "dd MMM hh:mm a"
            return dt
        }
    }
    
    
    class func encode(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    class func decode(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    
    class func getCurrentTimeZone() -> String {
        let localTimeZoneAbbreviation: Int = TimeZone.current.secondsFromGMT()
        let items = (localTimeZoneAbbreviation / 3600)
        return "\(items)"
    }
    
    
    
    
    
    // MARK: COMMON API(S)
    class func callUpdateFCMTokenOnServer(newToken:String,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.updateToken, param: [Update_Token.deviceId:newToken], shouldAnimateHudd: false) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    class func callLikeUnlikeApi(postId:Int,status:Bool,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.like_dislike_post, param: [like_UnlikePost.post_id:postId,like_UnlikePost.like_status:status], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    class func callFavouriteUnfavouriteApi(postId:Int,status:Bool,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.set_favourite, param: [fav_UnfavouritePost.post_id:postId,fav_UnfavouritePost.fav_status:status], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    class func callReportPostApi(postId:Int,reason:String,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.report_user, param: [reportPost.post_id:postId,reportPost.reason:reason], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    class func callFollowUnFollowApi(follow_to:Int,followStatus:Int,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.set_follow, param: [Follow_UnFollow.follow_to:follow_to,Follow_UnFollow.follow_status:followStatus], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignUpModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    class func callAcceptRejectOrderApi(order_id:Int,order_status:Bool,_completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.accept_DeclineOrder, param: [Accept_DeclineOrder.order_id:order_id,Accept_DeclineOrder.order_status:order_status], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                print(data)
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    
}

