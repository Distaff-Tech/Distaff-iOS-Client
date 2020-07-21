//
//  CreatePostPopupVC.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class CreatePostPopupVC: BaseClass {
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        showNavigationBar()
    }
}

//MARK:ALL METHOD(S)
extension CreatePostPopupVC {
    
    
}

//MARK:ALL ACTION(S)
extension CreatePostPopupVC {
    @IBAction func didTappedClose(_ sender: UIButton) {
        dismissVC()
    }
    
    @IBAction func didTappedInsertImage(_ sender: UIButton) {
        openCameraGalleryPopUp()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageCaptured = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        dismiss(animated: false) {
            self.dismiss(animated: true) {
                let imagObject = ColorScheme(colorId: Variables.shared.selectedColorId ?? 0, image: imageCaptured,isSelected: Variables.shared.imageColorArray.count == 0 ? true : false)
                Variables.shared.imageColorArray.append(imagObject)
                
                let targetVC = appDelegateRef.window?.rootViewController as? TabbarVC
                let Addpost = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.addPostVC) as? AddPostVC
                let nav = targetVC?.selectedViewController as? UINavigationController
                nav?.pushViewController(Addpost ?? UIViewController(), animated: true)
            }
        }
        
    }
    
    @IBAction func didTappedCustomDesign(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let tabbar = appDelegateRef.window?.rootViewController as? TabbarVC
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.customDesignVC) as? CustomDesignVC
            let nav = tabbar?.selectedViewController as? UINavigationController
            nav?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        
    }
}
