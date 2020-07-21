//
//  SignUpVC.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SignUpVC: BaseClass {
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPhoneNumber: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldReEnterPassword: UITextField!
    
    let objSignUpVM = SignUpVM()
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
        // Dummy  data
//                txtFldEmail.text = "abc@yopmail.com"
//                txtFldPassword.text = "11111111"
//                txtFldReEnterPassword.text = "11111111"
        
    }
    
}
//MARK:ALL METHODS(S)
extension SignUpVC {
    func prepareUI() {
        hideNavigationBar()
    }
}
//MARK:ALL ACTION(S)
extension SignUpVC {
    @IBAction func didTappedSignIN(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedSignUp(_ sender: UIButton) {
        dismissKeyboard()
        objSignUpVM.callSignUpApi(SignUP.Request(email: txtFldEmail.text, phoneNumber: txtFldPhoneNumber.text, password: txtFldPassword.text, confirmPassword: txtFldReEnterPassword.text)) { (data) in
            self.showAlertWithAction(message: data?.message ?? "") {
                self.PopViewController()
            }
        }
        
    }
}
