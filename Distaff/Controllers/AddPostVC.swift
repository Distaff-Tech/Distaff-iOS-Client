//
//  AddPostVC.swift
//  Distaff
//
//  Created by netset on 10/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class AddPostVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet weak var txtFldDescription: UITextView!
    @IBOutlet weak var txtFldClthMaterial: UITextField!
    @IBOutlet weak var collectionViewSize: UICollectionView!
    @IBOutlet weak var collectionViewColorScheme: UICollectionView!
    @IBOutlet weak var imgViewPostImage: UIImageView!
    
    //MARK:VARIABLE(S)
    var objVMAddPost = AddPostVM()
    var isFromCustomDesign = false
    var minimumPrice:Double?
    var serverMinimumPrice:Double?
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    //MARK:OVERRIDE METHOD(S)
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
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        let imagObject = ColorScheme(colorId: Variables.shared.selectedColorId ?? 0, image: image,isSelected:Variables.shared.imageColorArray.count == 0 ? true :false)
        Variables.shared.imageColorArray.append(imagObject)
        dismiss(animated: true) {
            self.openSelectColorScreen()
        }
    }
    
    
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtFldClthMaterial  {
            
            if Variables.shared.fabricListArray.count == 0 {
                self.showAlert(message:Messages.NoDataMessage.noClothMaterialList)
                return false
            }
            
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.clothMaterialPoupVC) as? ClothMaterialPoupVC
            targetVC?.modalPresentationStyle = .overCurrentContext
            targetVC?.clothMaterialList = Variables.shared.fabricListArray
            targetVC?.callBackFabricSelected = { selectedArray in
                print(selectedArray)
                
                DispatchQueue.main.async {
                    self.dismissKeyboard()
                }
                
                let selectedIndex = selectedArray.firstIndex(where: {$0.isSelected == true })
                Variables.shared.fabricListArray = selectedArray
                
                self.txtFldClthMaterial.text =  selectedArray[selectedIndex ?? 0].fabric
            }
            
            DispatchQueue.main.async {
                self.navigationController?.present(targetVC ?? UIViewController(), animated: true, completion: nil)
                self.dismissKeyboard()
            }
            
            return false
        }
        else {
            return true
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFldPrice {
            // Get text
            let currentText = textField.text ?? ""
            let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Validate
            return replacementText.isValidDecimal(maximumFractionDigits: 2)
        }
        
        return true
    }
    
}
//MARK:ALL METHOD(S)
extension AddPostVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        txtFldDescription.setPlaceholder(with: "Enter Description", padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 20), placeholderColor:#colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1))
        imgViewPostImage.image =  Variables.shared.imageColorArray[0].image
        fetchColor_SizeArray()
    }
    
    func reflectColorSelectedArray(indexPath:Int) {
        for i in 0..<Variables.shared.imageColorArray.count {
            Variables.shared.imageColorArray[i].isSelected = false
        }
        Variables.shared.imageColorArray[indexPath].isSelected = true
        collectionViewColorScheme.reloadData()
    }
    
    func fetchColor_SizeArray() {
        objVMAddPost.callGetSize_ColorListApi { (data) in
            self.collectionViewSize.reloadData()
            self.collectionViewColorScheme.reloadData()
            self.openSelectColorScreen()
            self.serverMinimumPrice = self.objVMAddPost.definedMinimumPrice ?? 0.0
            if self.isFromCustomDesign {
                self.objVMAddPost.definedMinimumPrice = self.minimumPrice
            }
        }
    }
    
    func openSelectColorScreen() {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chooseColorVC) as? ChooseColorVC
        targetVC?.modalPresentationStyle = .overCurrentContext
        
        targetVC?.callBackSelectedColor = { id in
            var object = Variables.shared.imageColorArray[Variables.shared.imageColorArray.count - 1]
            object.colorId = id
            Variables.shared.imageColorArray[Variables.shared.imageColorArray.count - 1] = object
            self.collectionViewColorScheme.reloadData()
            
            if Variables.shared.imageColorArray.count == 1 {
                self.imgViewPostImage.image = Variables.shared.imageColorArray[0].image
            }
            let indexPath = NSIndexPath(item: Variables.shared.imageColorArray.count, section: 0)
            self.collectionViewColorScheme.scrollToItem(at: indexPath as IndexPath, at: .right, animated: true)
            print(Variables.shared.imageColorArray)
        }
        self.navigationController?.present(targetVC ?? UIViewController(), animated: true, completion: nil)
    }
    
}
//MARK:ALL ACTION(S)
extension AddPostVC {
    @IBAction func didPressedSubmit(_ sender: UIButton) {
        dismissKeyboard()
        
        if !isBankAdded().0 {
           
            let targetVc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.addBankVC) as? AddBankVC
            targetVc?.isFromAddPostPage = true
            targetVc?.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(targetVc ?? UIViewController(), animated: true)
            return
        }
        
        
        let sizeArray = Variables.shared.sizeListArray.filter({$0.isSelected == true})
        let selectedSizeIds = sizeArray.compactMap{(String($0.id ?? 0))}
        let clothMaterialArray = Variables.shared.fabricListArray.filter({$0.isSelected == true})
        let selectedClothMaterialIds = clothMaterialArray.compactMap{(String($0.id ?? 0))}
        let request = AddPost.Request(price: txtFldPrice.text, description: txtFldDescription.text, clothMaterial: selectedClothMaterialIds, sizesAvailable: selectedSizeIds, postImage: imgViewPostImage.image)
        objVMAddPost.callAddPostApi(request) { (addPostdata) in
            self.showAlertWithAction(message:Messages.CustomServerMessages.addPostSuccessfully) {
                Variables.shared.shouldLoadProfileData = true
                Variables.shared.imageColorArray.removeAll()
                self.popToRootVc()
            }
        }
    }
    
    @IBAction func didTappedBack(_ sender: UIButton) {
        self.showAlertWithActionAndCancel(message: Messages.DialogMessages.cancelPosting) {
            self.popToRootVc()
            Variables.shared.imageColorArray.removeAll()
        }
        
        
    }
    
    @IBAction func didTappedCameraIcon(_ sender: UIButton) {
        openCameraGalleryPopUp()
    }
    
}
