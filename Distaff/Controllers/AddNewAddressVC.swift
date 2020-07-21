//
//  AddNewCardVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class AddNewAddressVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldMobileNo: UITextField!
    @IBOutlet weak var txtFldAddress: UITextField!
    @IBOutlet weak var txtFldCity: UITextField!
    @IBOutlet weak var txtFldPostalCode: UITextField!
    
    //MARK:VARIABLE(S)
    var callBackAddAddress : ((_ data:AddressData) -> ())?
    let objAddNewAddressVM = AddNewAddressVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
        
}
//MARK:ALL METHODS(S)
extension AddNewAddressVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
    }
}

//MARK:ALL ACTION(S)
extension AddNewAddressVC {
    @IBAction func didTappedSubmit(_ sender: UIButton) {
        dismissKeyboard()
        
        objAddNewAddressVM.callAddAddressApi(AddNewAddress.Request(firstName: txtFldFirstName.text, lastName: txtFldLastName.text, mobileNumber: txtFldMobileNo.text, address: txtFldAddress.text, city: txtFldCity.text, postalCode: txtFldPostalCode.text)) { (data) in
            self.callBackAddAddress?(data!)
            self.PopViewController()
        }
        
        
        
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
        
    }
    
}
