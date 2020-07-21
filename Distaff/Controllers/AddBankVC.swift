//
//  AddBankVC.swift
//  Distaff
//
//  Created by Aman on 02/06/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class AddBankVC: BaseClass {
    
    @IBOutlet var txtFldActHolderName: UITextField!
    @IBOutlet var txtFldActType: UITextField!
    @IBOutlet var txtFldRoutingNumber: UITextField!
    @IBOutlet var txtFldActNumber: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var btnback: UIButton!
    
    let objVM = AddBankVM()
    var isFromAddPostPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return objVM.accountTypeArray.count
    }
    
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return objVM.accountTypeArray[row]
    }
    
    override func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name:AppFont.fontRegular, size:18)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = objVM.accountTypeArray[row]
        pickerLabel?.textColor = UIColor.black
        return pickerLabel!
    }
    
    override  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFldActType.text  = objVM.accountTypeArray[row]
    }
    
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFldActType && textField.text?.count == 0 {
            textField.text = objVM.accountTypeArray[0]
        }
        else if textField == txtFldActType {
            let indexOfSelected = objVM.accountTypeArray.firstIndex(of: txtFldActType.text ?? "") ?? 0
            pickerView.selectRow(indexOfSelected, inComponent: 0, animated: true)
        }
        
    }
    
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedSave(_ sender: UIButton) {
        dismissKeyboard()
        objVM.callAddBankApi(AddBank.Request(acoountHolderName: txtFldActHolderName.text, accountHolderType: txtFldActType.text, routingNumber: txtFldRoutingNumber.text, bankAccountNumber: txtFldActNumber.text)) { (data) in
            userdefaultsRef.set(encodable: data?.bank_detail, forKey: UserDefaultsKeys.bankInfo)
            self.showAlertWithAction(message: data?.message ?? "") {
                self.PopViewController()
           
            }
            
        }
        
    }
    
    
}

extension AddBankVC {
    func prepareUI() {
        addPickerViewInTextField(textField: txtFldActType)
        btnSubmit.setTitle(isBankAdded().0 ? "UPDATE" : "SUBMIT", for: .normal)
        self.title = isBankAdded().0 ? "EDIT BANK" : "ADD BANK"
        
        // set prefilled Data
        if isBankAdded().0 {
            txtFldActHolderName.text = isBankAdded().1?.account_name ?? ""
            txtFldActType.text = isBankAdded().1?.type ?? ""
            txtFldRoutingNumber.text = isBankAdded().1?.routing_number ?? ""
            txtFldActNumber.text = isBankAdded().1?.acc_number ?? ""
        }
        
    }
    
}


