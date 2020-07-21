//
//  SignIN DataSource + Delegates.swift
//  Distaff
//
//  Created by netset on 05/02/20.
//  Copyright © 2020 netset. All rights reserved.
//


import Foundation
import UIKit
import FirebaseAuth
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import InstagramLogin
import AuthenticationServices

//MARK:-  GOOGLE DELEGATE(S) 
extension SignInVC:GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            //                        print(user)
            let userId = user.userID                  // For client-side use only!
            //            let token = user.authentication.idToken // Safe to send to the server
            let name = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            var userProfile:URL?
            // for profile pic
            if GIDSignIn.sharedInstance()?.currentUser.profile.hasImage ?? false {
                let  thumbSize = CGSize(width: 500, height: 500)
                let dimension = round(thumbSize.width * UIScreen.main.scale);
                userProfile = user.profile.imageURL(withDimension: UInt(dimension))
            }
            let fullName = "\(givenName ?? "") \(familyName ?? "")"
            objSIgnInVM.callSocialSignInApi(info: SocialInfo_User(email: email, socialId: userId, userName: name, fullName: fullName, profilePic: userProfile,loginType: "i"))
            
        } else {
            ActivityIndicatorManager.sharedInstance.stopAnimating()
            print("\(error.localizedDescription)")
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        ActivityIndicatorManager.sharedInstance.stopAnimating()
        print("\(error.localizedDescription)")
    }
}


//MARK:-  INSTAGRAM DELEGATE(S) 
extension SignInVC: InstagramLoginViewControllerDelegate  {
    func instagramLoginDidFinish(accessToken: String?, error: InstagramError?) {
        if error != nil {
            // show error alert
            debugPrint(error ?? "error")
            return
        }
        objSIgnInVM.instagramLogin.dismiss(animated: true)
        objSIgnInVM.getInstagramToken(url: "https://api.instagram.com/oauth/access_token", param: ["client_id":InstagramInfo.INSTAGRAM_CLIENT_ID,"client_secret":InstagramInfo.INSTAGRAM_CLIENTSERCRET,"grant_type":"authorization_code","redirect_uri":InstagramInfo.INSTAGRAM_REDIRECT_URI,"code":accessToken ?? ""])
    }
    
}

extension SignInVC : ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email
            
            
            //Navigate to other view controller
        }else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            //Navigate to other view controller
        }
        
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension SignInVC: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
