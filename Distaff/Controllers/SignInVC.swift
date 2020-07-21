//
//  SignInVC.swift
//  Distaff
//
//  Created by netset on 09/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import Alamofire
import AuthenticationServices



class SignInVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet var btnSignInApple: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    //MARK:VARAIBLE(S)
    let objSIgnInVM = SignInVM()
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        //  setupAppleSignInButton()
        btnSignInApple.isHidden = true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUI()
    }
    
}

//MARK:ALL METHODS(S)
extension SignInVC {
    func prepareUI() {
        hideNavigationBar()
    }
    @available(iOS 13.0, *)
    @objc func signInButtonTapped() {
        objSIgnInVM.loginWithApple(ref: self)
        
    }
    
    func setupAppleSignInButton() {
        if #available(iOS 13.0, *) {
            let btnAuthorization = ASAuthorizationAppleIDButton()
            btnAuthorization.frame = btnSignInApple.frame
            btnAuthorization.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
            stackView.addSubview(btnAuthorization)
        }
        else {
            btnSignInApple.isHidden = true
        }
    }
    
}


//MARK:ALL ACTION(S)
extension SignInVC {
    @IBAction func didTappedNewUser(_ sender: UIButton) {
        dismissKeyboard()
        pushToViewController(VC: ViewControllersIdentifers.signUpVC)
    }
    
    @IBAction func didTappedForgotPassword(_ sender: UIButton) {
        dismissKeyboard()
        pushToViewController(VC: ViewControllersIdentifers.forgotPassword)
    }
    
    @IBAction func didTappedSignIN(_ sender: UIButton) {
        dismissKeyboard()
        objSIgnInVM.callSignInApi(SignIN.Request(email: txtFldEmail.text, password: txtFldPassword.text)) { (data) in
            userdefaultsRef.set(encodable: data?.response, forKey: UserDefaultsKeys.userInfo)
            if !(data?.response?.is_profile_created ?? false) {
                if let hasAcceptedTerms =  userdefaultsRef.value(forKey: UserDefaultsKeys.hasAcceptedTermsCondition) {
                    print(hasAcceptedTerms)
                    self.pushToViewController(VC: ViewControllersIdentifers.createProfileVC)
                    return
                }
                self.presentViewControllerWithNavigation(withIdentifer: ViewControllersIdentifers.termsConditionVC)
            }
                
            else {
                userdefaultsRef.set(true, forKey: UserDefaultsKeys.isUserLogedIn)
                CommonMethods.setRoot(VC: homeStoryBoard.instantiateViewController(withIdentifier:ViewControllersIdentifers.tabbarVC))
            }
        }
        
    }
    
    @IBAction func didTappedSocialButton(_ sender: UIButton) {
        dismissKeyboard()
        if !InternetReachability.sharedInstance.isInternetAvailable() {
            Alert.displayAlertOnWindow(with: Messages.NetworkMessages.noInternetConnection)
            return
        }
        
        switch sender.tag {
        case 1:
            objSIgnInVM.loginWithFacebook(ref: self)
            
        case 2:
            objSIgnInVM.loginWithInstagram(ref: self)
        case 3:
            objSIgnInVM.loginWithGoogle(ref: self)
            
            
        default:
            print("")
        }
        
    }
    
}
