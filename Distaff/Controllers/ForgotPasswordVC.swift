//
//  ForgotPasswordVC.swift
//  Distaff
//
//  Created by netset on 09/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseClass {
    //MARK:OUTLET(S)
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldEmail: UITextField!
   
    //MARK:VARIABLE(S)
    let objForgotPasswordVM = ForgotPasswordVM()
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
}
//MARK:ALL METHODS(S)
extension ForgotPasswordVC {
    func prepareUI() {
        showNavigationBar()
        self.lblTitle.addInterlineSpacing(spacingValue: 6, text:Messages.TextMessages.forgotPassword)
    }
}
//MARK:ALL ACTION(S)
extension ForgotPasswordVC {
    @IBAction func didTappedResetPassword(_ sender: UIButton) {
        dismissKeyboard()
        objForgotPasswordVM.callForgotPasswordApi(ForgotPassword.Request(email: txtFldEmail.text), _completion: { (Data) in
            self.presentViewController(withIdentifer: ViewControllersIdentifers.forgotPasswordPopup)
            
        })
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
}
