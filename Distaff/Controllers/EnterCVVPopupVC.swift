//
//  EnterCVVPopupVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class EnterCVVPopupVC: BaseClass {
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFldCvv: UITextField!
    
    //MARK:VARIABLE(S)
    let objMakePaymentVM = MakePaymentVM()
    
      //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
}


//MARK:ALL METHOD(S)
extension EnterCVVPopupVC {
    func prepareUI() {
        self.lblTitle.addInterlineSpacing(spacingValue: 6, text:Messages.TextMessages.enterCvv)
    }
    
    
    func formValidations() -> Bool {
        var message = ""
        if txtFldCvv.text?.whiteSpaceCount(text: txtFldCvv.text ?? "") == 0 {
            message = Messages.Validation.enterCvvNumber
        }
        else  if txtFldCvv.text?.count ?? 0 < 3 {
            message = Messages.Validation.enterValidCvv
        }
            
        else {
            return true
        }
        if message != "" {
            Alert.displayAlertOnWindow(with: message)
        }
        return false
    }
    
    
}
//MARK:ALL ACTION(S)
extension EnterCVVPopupVC {
    
    @IBAction func didTappedSubmit(_ sender: UIButton) {
  
      
        
    }
    
    @IBAction func didTappedClose(_ sender: UIButton) {
        dismissVC()
    }
    
}
