//
//  SetPaymentVC.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
class SetPaymentVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var txtFldCardNo: UITextField!
    @IBOutlet weak var txtFldCardHolderName: UITextField!
    @IBOutlet weak var txtFldExpiryDate: UITextField!
    @IBOutlet weak var txtFldCVV: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    //MARK:VARIABLE(S)
    var isFromPostFlow = false
    var callBackCardAdded:((_ CardObject:Cards?) -> ())?
    let objSetPaymentVM = SetPaymentVM()
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFldExpiryDate {
            let selectedMonth = expiryDatePicker.selectedRow(inComponent: 0) + 1
            let selectedYear = expiryDatePicker.years?[expiryDatePicker.selectedRow(inComponent: 1)]
            textField.text = "\(selectedMonth)/\((selectedYear) ?? 0)"
        }
    }
    
}

//MARK:ALL METHODS(S)
extension SetPaymentVC {
    func prepareUI() {
        showNavigationBar()
        addExpiryDatePickerInTextField(textField: txtFldExpiryDate)
        btnBack.isHidden = !isFromPostFlow
        btnSkip.isHidden = isFromPostFlow
        txtFldCardHolderName.text = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.fullname
    }
}

//MARK:ALL ACTION(S)
extension SetPaymentVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
        
    }
    
    @IBAction func didTappedSkip(_ sender: UIButton) {
        CommonMethods.setRoot(VC: homeStoryBoard.instantiateViewController(withIdentifier:ViewControllersIdentifers.tabbarVC))
    }
    @IBAction func didTappedSubmit(_ sender: UIButton) {
        dismissKeyboard()
        objSetPaymentVM.callAddCardApi(AddCard.Request(cardNumber: txtFldCardNo.text, name: txtFldCardHolderName.text, expiryDate: txtFldExpiryDate.text, cvv: txtFldCVV.text)) { (data) in
            if self.isFromPostFlow {
                self.PopViewController()
                self.callBackCardAdded?(data)
                return
            }
            CommonMethods.setRoot(VC: homeStoryBoard.instantiateViewController(withIdentifier:ViewControllersIdentifers.tabbarVC))
        }
        
    }
}
