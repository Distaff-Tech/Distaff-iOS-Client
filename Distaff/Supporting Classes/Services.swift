

import Foundation
import UIKit
import SystemConfiguration
import Alamofire
class Services: NSObject {
    
    class func headers() -> HTTPHeaders {
        
        if let tokenValue = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.token {
            let headers: HTTPHeaders = ["Content-Type":"application/json",
                                        "Authorization":"\(tokenValue)","AppVersion":AppInfo.appCurrentVersion
            ]
            return headers
        }
        else {
            let headers: HTTPHeaders = ["Content-Type":"application/json","AppVersion":AppInfo.appCurrentVersion]
            return headers
        }
        
    }
    
    class  func postRequest(url:String,param:[String:Any],shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil, completionBlock: @escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            if shouldAnimateHudd {
                ActivityIndicatorManager.sharedInstance.startAnimating()
            }
            print("url is ====================== \(url)")
            print("Header is =================== \(Services.headers())")
            print("param is ==================== \(param)")
            print("=============================")
            Alamofire.request(url, method : .post, parameters : param, encoding : JSONEncoding.default , headers : Services.headers()).responseJSON { (response:DataResponse) in
                print("StatusCode is =============== \(response.response?.statusCode ?? 1100 )")
                print(response)
                if shouldAnimateHudd {
                    ActivityIndicatorManager.sharedInstance.stopAnimating()
                }
                
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
                
                switch(response.result)
                {
                case .success:
                    if let responseData = response.data {
                        do {
                            if response.response?.statusCode == 200 {
                                completionBlock(responseData)
                            }
                                
                            else if response.response?.statusCode == 401 {
                                CommonMethods.handleSessionExpire(message:Messages.NetworkMessages.seassionLogout)
                            }
                                
                            else if response.response?.statusCode == 426 {
                                CommonMethods.newVersionExist()
                            }
                                
                                
                            else {
                                if let message = response.result.value as? [String : Any]
                                {
                                    if (message["message"] as? String) != nil
                                    {
                                        let alertController = UIAlertController(title: AppInfo.appName, message:
                                            (message["message"] as? String ?? ""), preferredStyle: .alert)
                                        alertController.view.tintColor = AppColors.appColorBlue
                                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            
                                            if url.contains("addtocart")  {
                                                if   let tab =  appDelegateRef.window?.rootViewController as? UITabBarController {
                                                    let selectedIndex = tab.selectedIndex
                                                    let selectedNavigation = tab.viewControllers?[selectedIndex] as? UINavigationController
                                                    selectedNavigation?.popViewController(animated: true)
                                                    
                                                }
                                            }
                                            
                                            
                                            
                                        }))
                                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                    }
                                    else
                                    {
                                        let alertController = UIAlertController(title: AppInfo.appName, message:
                                            "Server error!", preferredStyle: .alert)
                                        alertController.view.tintColor = AppColors.appColorBlue
                                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                        }))
                                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        let alertController = UIAlertController(title: AppInfo.appName, message:
                            response.error?.localizedDescription, preferredStyle: .alert)
                        alertController.view.tintColor = AppColors.appColorBlue
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                        }))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: AppInfo.appName, message:
                        error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    alertController.view.tintColor = AppColors.appColorBlue
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
            }
            let alertController = UIAlertController(title: AppInfo.appName, message:
                Messages.NetworkMessages.noInternetConnection, preferredStyle: .alert)
            alertController.view.tintColor = AppColors.appColorBlue
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    class  func getRequest(url:String,shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil, completionBlock: @escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            if shouldAnimateHudd {
                ActivityIndicatorManager.sharedInstance.startAnimating()
            }
            print("url is ====================== \(url)")
            print("Header is =================== \(Services.headers())")
            print("=============================")
            Alamofire.request(url, method : .get, encoding : JSONEncoding.default , headers : Services.headers()).responseJSON { (response:DataResponse) in
                print("StatusCode is =============== \(response.response?.statusCode ?? 1100 )")
                print(response)
                if shouldAnimateHudd {
                    ActivityIndicatorManager.sharedInstance.stopAnimating()
                }
                
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
                
                
                switch(response.result)
                {
                case .success:
                    if let responseData = response.data {
                        do {
                            if response.response?.statusCode == 200 {
                                completionBlock(responseData)
                            }
                                
                            else if response.response?.statusCode == 401 {
                                CommonMethods.handleSessionExpire(message: Messages.NetworkMessages.seassionLogout)
                            }
                                
                            else if response.response?.statusCode == 426 {
                                CommonMethods.newVersionExist()
                            }
                                
                            else {
                                if let message = response.result.value as? [String : Any]
                                {
                                    if (message["message"] as? String) != nil
                                    {
                                        let alertController = UIAlertController(title: AppInfo.appName, message:
                                            (message["message"] as? String ?? ""), preferredStyle: .alert)
                                        alertController.view.tintColor = AppColors.appColorBlue
                                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            
                                            if url.contains("get_post") || url.contains("getcomment") {
                                                if   let tab =  appDelegateRef.window?.rootViewController as? UITabBarController {
                                                    let selectedIndex = tab.selectedIndex
                                                    let selectedNavigation = tab.viewControllers?[selectedIndex] as? UINavigationController
                                                    selectedNavigation?.popViewController(animated: true)
                                                    
                                                }
                                            }
                                            
                                        }))
                                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                    }
                                    else
                                    {
                                        let alertController = UIAlertController(title: AppInfo.appName, message:
                                            "Server error!", preferredStyle: .alert)
                                        alertController.view.tintColor = AppColors.appColorBlue
                                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                        }))
                                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        let alertController = UIAlertController(title: AppInfo.appName, message:
                            response.error?.localizedDescription, preferredStyle: .alert)
                        alertController.view.tintColor = AppColors.appColorBlue
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                        }))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: AppInfo.appName, message:
                        error.localizedDescription, preferredStyle: .alert)
                    alertController.view.tintColor = AppColors.appColorBlue
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
            }
            
            let alertController = UIAlertController(title: AppInfo.appName, message:
                Messages.NetworkMessages.noInternetConnection, preferredStyle: .alert)
            alertController.view.tintColor = AppColors.appColorBlue
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    class  func postRequestWithImage(imageName:String,url:String,shouldAnimateHudd:Bool,param:[String:String],image:UIImage?,completionBlock:@escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            if shouldAnimateHudd {
                ActivityIndicatorManager.sharedInstance.startAnimating()
            }
            print("url is ====================== \(url)")
            print("Header is =================== \(Services.headers())")
            print("param is ==================== \(param)")
            print("=============================")
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if let imageToUpload = image {
                    multipartFormData.append(imageToUpload.jpegData(compressionQuality: 1.0)!, withName:imageName, fileName: NSUUID().uuidString + ".jpeg", mimeType: "image/jpeg")
                }
                
                
                for (key, value) in param {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: url,method: url.contains("addpost") == true ? .post : .put , headers:Services.headers(), encodingCompletion: { (result) in
                
                switch result
                {
                    
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                    })
                    upload.responseJSON { response in
                        if shouldAnimateHudd {
                            ActivityIndicatorManager.sharedInstance.stopAnimating()
                        }
                        
                        print("StatusCode is =============== \(response.response?.statusCode ?? 1100 )")
                        
                        if let responseData = response.data {
                            do {
                                if response.response?.statusCode == 200 {
                                    //                                    print("Resonse data is ----- \(responseData)")
                                    completionBlock(responseData)
                                }
                                else if response.response?.statusCode == 401 {
                                    CommonMethods.handleSessionExpire(message: Messages.NetworkMessages.seassionLogout)
                                }
                                    
                                else if response.response?.statusCode == 426 {
                                    CommonMethods.newVersionExist()
                                }
                                    
                                    
                                    
                                else {
                                    if let message = response.result.value as? [String : Any]
                                    {
                                        if (message["message"] as? String) != nil
                                        {
                                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                                (message["message"] as? String ?? ""), preferredStyle: .alert)
                                            alertController.view.tintColor = AppColors.appColorBlue
                                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            }))
                                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                        }
                                        else
                                        {
                                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                                "Server error!", preferredStyle: .alert)
                                            alertController.view.tintColor = AppColors.appColorBlue
                                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            }))
                                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                response.error?.localizedDescription, preferredStyle: .alert)
                            alertController.view.tintColor = AppColors.appColorBlue
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                            }))
                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        }
                    }
                    
                case .failure(let error):
                    if shouldAnimateHudd {
                        ActivityIndicatorManager.sharedInstance.stopAnimating()
                    }
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: AppInfo.appName, message:
                        error.localizedDescription, preferredStyle: .alert)
                    alertController.view.tintColor = AppColors.appColorBlue
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
            })
        }
        else {
            let alertController = UIAlertController(title: AppInfo.appName, message:
                Messages.NetworkMessages.noInternetConnection, preferredStyle: .alert)
            alertController.view.tintColor = AppColors.appColorBlue
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    class  func postRequestWithMultipleImages(imageName:String,url:String,shouldAnimateHudd:Bool,param:[String:String],images:[UIImage?],completionBlock:@escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            if shouldAnimateHudd {
                ActivityIndicatorManager.sharedInstance.startAnimating()
            }
            print("url is ====================== \(url)")
            print("Header is =================== \(Services.headers())")
            print("param is ==================== \(param)")
            print("=============================")
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                if images.count > 0  {
                    for i in 0..<images.count {
                        multipartFormData.append(images[i]!.jpegData(compressionQuality: 0.7)!, withName:imageName, fileName: NSUUID().uuidString + ".jpeg", mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in param {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: url,method:.post, headers:Services.headers(), encodingCompletion: { (result) in
                
                switch result
                {
                    
                    
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                    })
                    upload.responseJSON { response in
                        if shouldAnimateHudd {
                            ActivityIndicatorManager.sharedInstance.stopAnimating()
                        }
                        
                        
                        print("StatusCode is =============== \(response.response?.statusCode ?? 1100 )")
                        
                        
                        if let responseData = response.data {
                            do {
                                if response.response?.statusCode == 200 {
                                    //                                    print("Resonse data is ----- \(responseData)")
                                    completionBlock(responseData)
                                }
                                else if response.response?.statusCode == 401 {
                                    CommonMethods.handleSessionExpire(message: Messages.NetworkMessages.seassionLogout)
                                }
                                else if response.response?.statusCode == 426 {
                                    CommonMethods.newVersionExist()
                                }
                                    
                                    
                                    
                                else {
                                    if let message = response.result.value as? [String : Any]
                                    {
                                        if (message["message"] as? String) != nil
                                        {
                                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                                (message["message"] as? String ?? ""), preferredStyle: .alert)
                                            alertController.view.tintColor = AppColors.appColorBlue
                                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            }))
                                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                        }
                                        else
                                        {
                                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                                "Server error!", preferredStyle: .alert)
                                            alertController.view.tintColor = AppColors.appColorBlue
                                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                            }))
                                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            let alertController = UIAlertController(title: AppInfo.appName, message:
                                response.error?.localizedDescription, preferredStyle: .alert)
                            alertController.view.tintColor = AppColors.appColorBlue
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                            }))
                            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        }
                    }
                    
                case .failure(let error):
                    if shouldAnimateHudd {
                        ActivityIndicatorManager.sharedInstance.stopAnimating()
                    }
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: AppInfo.appName, message:
                        error.localizedDescription, preferredStyle: .alert)
                    alertController.view.tintColor = AppColors.appColorBlue
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
            })
        }
        else {
            let alertController = UIAlertController(title: AppInfo.appName, message:
                Messages.NetworkMessages.noInternetConnection, preferredStyle: .alert)
            alertController.view.tintColor = AppColors.appColorBlue
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
