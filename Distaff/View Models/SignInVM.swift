//
//  SignInVM.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import InstagramLogin
import Alamofire
import AuthenticationServices

class SignInVM {
    
    var instagramLogin: InstagramLoginViewController!
    
    func formValidations(_ request:SignIN.Request) -> Bool {
        var message = ""
        if request.email?.whiteSpaceCount(text: request.email ?? "") == 0 {
            message = Messages.Validation.enterEmail
        }
        else if request.password?.isEmpty ?? false {
            message = Messages.Validation.enterPassword
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
    
    
    func callSignInApi(_ request: SignIN.Request,_completion:@escaping(_ data:SignInModel?) -> Void) {
        if formValidations(request) {
            Services.postRequest(url: WebServicesApi.signIn, param: [Sign_In.email:request.email ?? "",Sign_In.password:request.password ?? "",Sign_In.deviceId :userdefaultsRef.value(forKey: UserDefaultsKeys.deviceId) as? String ?? "No Token",Sign_In.deviceType : AppInfo.deveiceType], shouldAnimateHudd: true) { (responseData) in
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
    
    
    func loginWithGoogle(ref:UIViewController) {
        ActivityIndicatorManager.sharedInstance.startAnimating()
        GIDSignIn.sharedInstance()?.presentingViewController = ref
        GIDSignIn.sharedInstance().delegate = ref as? GIDSignInDelegate
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func loginWithApple(ref:UIViewController) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self as? ASAuthorizationControllerDelegate
            authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding //
            authorizationController.performRequests()
        }
    }
    
    func loginWithInstagram(ref:UIViewController) {
        // https://github.com/AnderGoig/InstagramLogin :-- Helper link
        // 2. Initialize your 'InstagramLoginViewController' and set your 'ViewController' to delegate it
        instagramLogin = InstagramLoginViewController(clientId:InstagramInfo.INSTAGRAM_CLIENT_ID, redirectUri:InstagramInfo.INSTAGRAM_REDIRECT_URI)
        instagramLogin.delegate = ref as? InstagramLoginViewControllerDelegate
        
        // 3. Customize it
        instagramLogin.scopes = [.basic] // [.basic] by default; [.all] to set all permissions
        instagramLogin.title = "Instagram" // If you don't specify it, the website title will be showed
        instagramLogin.progressViewTintColor = .blue // #E1306C by default
        
        // If you want a .stop (or other) UIBarButtonItem on the left of the view controller
        instagramLogin.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissLoginViewController))
        
        // You could also add a refresh UIBarButtonItem on the right
        instagramLogin.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPage))
        
        // 4. Present it inside a UINavigationController (for example)
        ref.present(UINavigationController(rootViewController: instagramLogin), animated: true)
    }
    
    
    @objc func dismissLoginViewController() {
        instagramLogin.dismiss(animated: true)
    }
    
    @objc func refreshPage() {
        instagramLogin.reloadPage()
    }
    
    func getInstagramProfileData(url:String) {
        ActivityIndicatorManager.sharedInstance.startAnimating()
        
        Alamofire.request(url, method: .get,  encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch(response.result) {
                case .success (_):
                    print(response.result.value!)
                    
                    var socialInfo = SocialInfo_User()
                    if let dataDict = response.result.value as? NSDictionary {
                        
                        
                        if let id = dataDict.value(forKey: "id") as? String  {
                            socialInfo.socialId = id
                        }
                        
                        if let userName = dataDict.value(forKey: "username") as? String  {
                            socialInfo.userName = userName
                        }
                        
                        //                        if let profilePicture = (((dataDict).value(forKey: "data") as! NSDictionary).value(forKey: "profile_picture") as? String)  {
                        //                            socialInfo.profilePic = URL.init(string: profilePicture)
                        //                        }
                        //
                        //                        if let fullName = (((dataDict).value(forKey: "data") as! NSDictionary).value(forKey: "full_name") as? String)  {
                        //
                        //                            socialInfo.fullName = fullName
                        //                        }
                        socialInfo.loginType = "i"
                        self.callSocialSignInApi(info: socialInfo)
                        
                    }
                    else {
                        ActivityIndicatorManager.sharedInstance.stopAnimating()
                    }
                    
                    break
                case .failure (_):
                    
                    print(response.description)
                    self.instagramLogin.dismiss(animated: true)
                    ActivityIndicatorManager.sharedInstance.stopAnimating()
                    break
                }
        }
        
    }
    
    func getInstagramToken(url:String,param:[String:Any]) {
        ActivityIndicatorManager.sharedInstance.startAnimating()
        Alamofire.request(url, method: .post,parameters : param,  encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                switch(response.result) {
                case .success (_):
                    print(response.result.value!)
                    
                    if let dataDict = response.result.value as? NSDictionary {
                        
                        if let code = ((dataDict).value(forKey: "code") as? Int)  {
                            print(code)
                            ActivityIndicatorManager.sharedInstance.stopAnimating()
                            Alert.displayAlertOnWindow(with: "Something went wrong.")
                            
                        }
                        
                        if let access_token = ((dataDict).value(forKey: "access_token") as? String)  {
                            let userId = ((dataDict).value(forKey: "user_id") as? Int)
                            let url = "https://graph.instagram.com/\(userId ?? 0)?fields=username,id&access_token=\(access_token)"
                            self.getInstagramProfileData(url: url)
                        }
                        
                        
                    }
                    else {
                        ActivityIndicatorManager.sharedInstance.stopAnimating()
                    }
                    
                    self.instagramLogin.dismiss(animated: true)
                    break
                case .failure (_):
                    
                    print(response.description)
                    self.instagramLogin.dismiss(animated: true)
                    ActivityIndicatorManager.sharedInstance.stopAnimating()
                    break
                }
        }
        
    }
    
    
    func loginWithFacebook(ref:UIViewController) {
        let loginManager = LoginManager()
        ActivityIndicatorManager.sharedInstance.startAnimating()
        loginManager.logIn(permissions: ["public_profile", "email"], from: ref) { (result, error) in
            if((error) != nil) {
                print(error!)
                loginManager.logOut()
                ActivityIndicatorManager.sharedInstance.stopAnimating()
            }
            else if (result?.isCancelled)! {
                loginManager.logOut()
                ActivityIndicatorManager.sharedInstance.stopAnimating()
                return
            }
            else {
                //                loginManager.logOut()
                self.getFBUserData()
            }
        }
    }
    
    
    func callSocialSignInApi(info:SocialInfo_User?) {
        Services.postRequest(url: WebServicesApi.socialLogin, param: [Social_SignIN.email: info?.email ?? "",Social_SignIN.social_id: info?.socialId ?? "",Social_SignIN.deviceId : "123",Social_SignIN.deviceType : AppInfo.deveiceType,Social_SignIN.login_type:info?.loginType ?? ""], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SignInModel.self, from: responseData)
                userdefaultsRef.set(encodable: data.response, forKey: UserDefaultsKeys.userInfo)
                if !(data.response?.is_profile_created ?? false) {
                    Variables.shared.userSocialInfo = info
                    if let hasAcceptedTerms =  userdefaultsRef.value(forKey: UserDefaultsKeys.hasAcceptedTermsCondition) {
                        print(hasAcceptedTerms)
                        let targetVC = loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.createProfileVC) as? CreateProfileVC
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            if let topVC = UIApplication.getTopViewController() {
                                topVC.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
                            }
                        }
                        
                    }
                    else {
                        let targetVC = loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.termsConditionVC) as? TermsConditionVC
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            if let topVC = UIApplication.getTopViewController() {
                                let navigationController: UINavigationController = UINavigationController(rootViewController: targetVC!)
                                navigationController.modalPresentationStyle = .fullScreen
                                topVC.navigationController?.present(navigationController , animated: true)
                            }
                        }
                    }
                }
                    
                else {
                    userdefaultsRef.set(true, forKey: UserDefaultsKeys.isUserLogedIn)
                    CommonMethods.setRoot(VC: homeStoryBoard.instantiateViewController(withIdentifier:ViewControllersIdentifers.tabbarVC))
                }
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    func getFBUserData() {
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                
                if (error == nil){
                    print(result!)
                    var userProfileInfo = SocialInfo_User()
                    if let firstName = (result as! NSDictionary).value(forKey: "first_name") as? String {    // assigning First and Last name
                        userProfileInfo.userName = firstName
                    }
                    if let LastName = (result as! NSDictionary).value(forKey: "last_name") as? String {
                        let firstName = userProfileInfo.userName
                        userProfileInfo.fullName = "\(firstName ?? "") \(LastName)"
                    }
                    
                    
                    if let email = (result as! NSDictionary).value(forKey: "email") as? String {
                        userProfileInfo.email = email
                    }
                    
                    if let picture = (result as! NSDictionary).value(forKey: "picture") as? [String:AnyObject] {
                        let pic = picture["data"]?["url"] as? String
                        userProfileInfo.profilePic = NSURL.init(string: pic ?? "") as URL?
                    }
                    
                    let userId = ((result as! NSDictionary).value(forKey: "id") as? String) ?? ""
                    userProfileInfo.socialId = userId
                    userProfileInfo.loginType = "f"
                    self.callSocialSignInApi(info: userProfileInfo)
                }
                else{
                    print(error?.localizedDescription ?? "error")
                    ActivityIndicatorManager.sharedInstance.stopAnimating()
                }
                
            })
        }
    }
    
    
}
