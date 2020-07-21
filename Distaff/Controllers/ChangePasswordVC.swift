//
//  ChangePasswordVC.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseClass {
    //MARK:OUTLET(S)
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldCurrentPassword: UITextField!
    @IBOutlet weak var txtFldNewPassword: UITextField!
    @IBOutlet weak var txtFldReEnterPassword: UITextField!
    @IBOutlet weak var lblUserFullName: UILabel!
    
    //MARK:VARIABLE(S)
    let objChangePasswordVM = ChangePasswordVM()
    
      //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    
}
//MARK:ALL METHODS(S)
extension ChangePasswordVC {
    func prepareUI() {
        self.lblTitle.addInterlineSpacing(spacingValue: 6, text:Messages.TextMessages.changePassword)
        handleTabbarVisibility(shouldHide: true)
        self.lblUserFullName.text = "Hello, \((userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.fullname ?? "")"
        
    }
    
}
//MARK:ALL ACTION(S)
extension ChangePasswordVC {
    @IBAction func didTappedSave(_ sender: UIButton) {
        dismissKeyboard()
        objChangePasswordVM.callChangePasswordApi(ChangePassword.Request(currentPassword: txtFldCurrentPassword.text, newPassword: txtFldNewPassword.text, confirmPassword: txtFldReEnterPassword.text)) { (data) in
            self.showAlertWithAction(message: data?.message ?? "") {
                self.PopViewController()
            }
        }
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    
}


