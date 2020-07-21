//
//  CreateProfileVC.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class CreateProfileVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    @IBOutlet weak var txtFldUserName: UITextField!
    @IBOutlet weak var txtFldFullName: UITextField!
    @IBOutlet weak var txtDldAddress: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnBack: UIButton!
    
    var objCreateProfileVM = CreateProfileVM()
    var isFromEditProfile = false
    var profileData:GetProfileModel?
    
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = Variables.shared.userSocialInfo {    // from social media
            displayUsersSocialData(info: data)
        }
        if isFromEditProfile {
            displayUserProfileFilledData()
        }
        self.title = isFromEditProfile ? "EDIT PROFILE" : "CREATE PROFILE"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUI()
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgViewProfilePic.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        objCreateProfileVM.capturedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK:ALL METHODS(S)
extension CreateProfileVC {
    func prepareUI() {
        showNavigationBar()
        handleNavigationBarTranparency(shouldTranparent: true)
        handleTabbarVisibility(shouldHide: true)
        btnBack.isHidden = isFromEditProfile ? false :true
        txtFldUserName.isUserInteractionEnabled = isFromEditProfile ? false :true
    }
    
    func displayUsersSocialData(info:SocialInfo_User) {
        txtFldUserName.text = info.userName
        txtFldFullName.text = info.fullName
        imgViewProfilePic.setImageWithurl(urlString: info.profilePic as NSURL?)
        if let url = info.profilePic {
            if let data = try? Data(contentsOf: url)
            {
                objCreateProfileVM.capturedImage = UIImage(data: data)!
            }
        }
    }
    
    func displayUserProfileFilledData() {
        imgViewProfilePic.setSdWebImage(url:profileData?.data?.image ?? "")
        txtFldUserName.text = profileData?.data?.user_name ?? ""
        txtFldFullName.text = profileData?.data?.fullname ?? ""
        txtDldAddress.text = profileData?.data?.address ?? ""
    }
    
}

//MARK:ALL ACTION(S)
extension CreateProfileVC {
    @IBAction func didTappedNext(_ sender: UIButton) {
        dismissKeyboard()
        let request = CreateProfile.Request(userName: txtFldUserName.text, fullName: txtFldFullName.text, completeAddress: txtDldAddress.text,profilePicture:objCreateProfileVM.capturedImage, isFirstPage: true,isFromEditProfile:isFromEditProfile ? 1:0)
        if objCreateProfileVM.formValidations(request) {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.completeProfileVC) as? CompleteProfileVC
            targetVC?.profileInfo = request
            targetVC?.profileData = profileData
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
    }
    
    @IBAction func didTappedProfile(_ sender: UIButton) {
        openCameraGalleryPopUp()
    }
}


