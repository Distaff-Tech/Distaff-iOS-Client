//
//  CompleteProfileVC.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class CompleteProfileVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var txtFldDate: UITextField!
    @IBOutlet weak var txtViewAbout: UITextView!
    
    //MARK:VARIABLE(S)
    var objCreateProfileVM = CreateProfileVM()
    var profileInfo:CreateProfile.Request?
    var profileData:GetProfileModel?
    
    
    
     //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUI()
    }


    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFldDate && (textField.text?.isEmpty)! {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            txtFldDate.text = formatter.string(from: datePicker.date)
        }
    }
    
    
    override func handleDatePickerSelection() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtFldDate.text = formatter.string(from: datePicker.date)
    }
    
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        else {
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let numberOfChars = newText.count
            return numberOfChars < 201
        }
        
    }
    
    
}

//MARK:ALL METHODS(S)
extension CompleteProfileVC {
    func prepareUI() {
        self.title = profileData != nil ? "EDIT PROFILE" : "COMPLETE PROFILE"
        handleNavigationBarTranparency(shouldTranparent: false)
        showNavigationBar()
        txtViewAbout.setPlaceholder(with: "Enter Description", padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20), placeholderColor:#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1))
        addDatePickerInTextField(textField: txtFldDate)
        
        if profileData != nil {
            btnMale.isSelected = profileData?.data?.gender ?? "" == "M"
            btnFemale.isSelected = profileData?.data?.gender ?? "" == "F"
            txtFldDate.text =  CommonMethods.convertDateFormat(inputFormat: "yyyy-MM-dd", outputFormat: "MM-dd-yyyy", dateString: profileData?.data?.date_of_birth ?? "")
            txtViewAbout.text = profileData?.data?.about_me ?? ""
        }
        
    }
    
}

//MARK:ALL ACTION(S)
extension CompleteProfileVC {
    @IBAction func didTappedGenderButtons(_ sender: UIButton) {
        btnMale.isSelected = sender == btnMale ? true :false
        btnFemale.isSelected = sender == btnFemale ? true :false
        
    }
    @IBAction func didTappedback(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedSubmit(_ sender: UIButton) {
        let request = CreateProfile.Request(userName: profileInfo?.userName, fullName: profileInfo?.fullName, completeAddress: profileInfo?.completeAddress,profilePicture:profileInfo?.profilePicture ,gender: btnMale.isSelected ? "M":"F", DateOfBirth: txtFldDate.text, about: txtViewAbout.text, isFirstPage: false,isFromEditProfile:profileData != nil ? 1 : 0)
        objCreateProfileVM.callCreateProfileApi(request) { (data) in
            var userinfo = userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo)
            userinfo?.user_name = data?.data?.user_name
            userinfo?.fullname = data?.data?.fullname
            userinfo?.address = data?.data?.address
            userinfo?.gender = data?.data?.gender
            userinfo?.about_me = data?.data?.about_me
            userinfo?.date_of_birth = data?.data?.date_of_birth
            userinfo?.image = data?.data?.image
            userdefaultsRef.set(encodable: userinfo, forKey: UserDefaultsKeys.userInfo)
            if self.profileData != nil {
                Variables.shared.shouldLoadProfileData = true
                self.popToRootVc()
            }
            else  {
                Variables.shared.userSocialInfo = nil
                 userdefaultsRef.set(true, forKey: UserDefaultsKeys.isUserLogedIn)
                self.pushToViewController(VC: ViewControllersIdentifers.paymentVC)
            }
        }
        
    }
}



