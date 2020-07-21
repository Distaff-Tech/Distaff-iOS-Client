//
//  HelpAndSupportVC.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class HelpAndSupportVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldFullName: UITextField!
    @IBOutlet weak var txtFldEmailAddress: UITextField!
    @IBOutlet weak var txtDldSubject: UITextField!
    @IBOutlet weak var txtViewMessage: UITextView!
    
    //MARK:VARIABLE(S)
    let objHelpAndSupport = HelpAndSupportVM()
    
      //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
}

//MARK:ALL METHODS(S)
extension HelpAndSupportVC {
    func prepareUI() {
        txtViewMessage.setPlaceholder(with: "Enter Message", padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20), placeholderColor:#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1))
        self.lblTitle.addInterlineSpacing(spacingValue: 6, text:Messages.TextMessages.helpAndSupport)
        handleTabbarVisibility(shouldHide: true)
    }
}

//MARK:ALL ACTION(S)
extension HelpAndSupportVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedSave(_ sender: UIButton) {
        dismissKeyboard()
        objHelpAndSupport.callContactUsApi(HelpAndSupport.Request(name: txtFldFullName.text, email: txtFldEmailAddress.text, subject: txtDldSubject.text, message: txtViewMessage.text), _completion: { (data) in
            self.showAlertWithAction(message: data?.message ?? "") {
                self.PopViewController()
            }
            
        })
        
        
    }
}
