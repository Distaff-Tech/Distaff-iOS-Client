//
//  CustomDesignVC.swift
//  Distaff
//
//  Created by Aman on 09/04/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import ScalingCarousel
import Photos


class CustomDesignVC: BaseClass {
    
    //MARK: OUTLET(S)
    @IBOutlet weak var collectionViewProductList: ScalingCarouselView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnSaveToGallary: UIButton!
    @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionBottomAnchor: NSLayoutConstraint!
    @IBOutlet weak var stackViewStepInfo: UIStackView!
    @IBOutlet weak var lblCurrentStep: UILabel!
    @IBOutlet weak var lblFilterName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNextFilter: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    var objVMCustomDesign = CustomDesignVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    //MARK:OVERRIDE METHOD(S)
    override func deleteObject() {
        if objectToDelete == recentShapeAdded {
            bottomCollectionView.isHidden = true
            stackViewStepInfo.isHidden = true
            btnBack.isHidden =  true
            btnNextFilter.isHidden =  true
            self.resetColors()
            self.objVMCustomDesign.selectedFilterOption = -1
            self.objVMCustomDesign.cutFilterCurrentIndex = 1
            unSelectedAllArrays()
            recentShapeAdded = nil
            
        }
        print(objectToDelete?.tag ?? 0)
        addedShapesPriceArray[objectToDelete?.tag ?? 0] = 0.0
        
        if objectToDelete?.restorationIdentifier == RestorationIdentifer.stickerView {
            let selectedPatternIndex = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.firstIndex(where:{$0.isSelected == true})
            
            if selectedPatternIndex == 0 && numberOfShapedAdded() == 0 {
                nextButtonUIHandling(shouldEnabled: false)
                
            }
            
        }
        else {
            
            let selectedPatternIndex = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.firstIndex(where:{$0.isSelected == true})
            
            if selectedPatternIndex == 0 && numberOfShapedAdded()  == 0 &&  !isStickerViewAdded() {
                nextButtonUIHandling(shouldEnabled: false)
                
            }
            
        }
        
        objectToDelete?.removeFromSuperview()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        resetColors()
        nextButtonUIHandling(shouldEnabled: true)
        objVMCustomDesign.selectedFilterOption = -1
        addStickerImageInView(selectedImage:info[UIImagePickerController.InfoKey.editedImage] as? UIImage ?? UIImage(), productImage: productImage)
        
    }
    
    
    override  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        resetColors()
        objVMCustomDesign.selectedFilterOption = -1
    }
    
    
    
}

//MARK: ALL METHOD(S)
extension CustomDesignVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        getAllProducts()
    }
    
    func getAllProducts() {
        objVMCustomDesign.callProductListsApi(shouldAnimate: true) {
            self.collectionViewProductList.reloadData()
            // scroll to 2nd index
            if self.objVMCustomDesign.productData?.clothstyle?.count ?? 0 > 2 {
                let indexParh = NSIndexPath(item: 1, section: 0)
                self.collectionViewProductList.scrollToItem(at: indexParh as IndexPath, at: .centeredHorizontally, animated: false)
            }
        }
        
    }
    func unSelectedAllArrays() {
        //        objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.mutateEach({($0.isSelected = false)})
        //        objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.mutateEach({($0.isSelected = false)})
        
        objVMCustomDesign.productData?.shapesArray?.mutateEach({($0.isSelected = false)})
        objVMCustomDesign.productData?.shape_colour?.mutateEach({($0.isSelected = false)})
        objVMCustomDesign.productData?.fabric?.mutateEach({($0.isSelected = false)})
        objVMCustomDesign.productData?.fabric_colour?.mutateEach({($0.isSelected = false)})
        objVMCustomDesign.productData?.sew?.mutateEach({($0.isSelected = false)})
    }
    
    
    func handleCutFilterUI() {
        btnBack.isHidden  = objVMCustomDesign.cutFilterCurrentIndex == 1 ? true : false
        btnNextFilter.setTitle(objVMCustomDesign.cutFilterCurrentIndex == 5 ? "DONE" : "NEXT", for: .normal)
        lblFilterName.text = objVMCustomDesign.cutFilterCurrentIndex == 1 ? "CHOOSE SHAPE" :  objVMCustomDesign.cutFilterCurrentIndex == 2 ? "CHOOSE COLOR" : objVMCustomDesign.cutFilterCurrentIndex == 3 ? "CHOOSE FABRIC" : objVMCustomDesign.cutFilterCurrentIndex == 4 ? "CHOOSE FABRIC COLOR" :  "CHOOSE SEW"
        lblCurrentStep.text = objVMCustomDesign.cutFilterCurrentIndex == 1 ? "STEP 1 OUT OF 5" :  objVMCustomDesign.cutFilterCurrentIndex == 2 ? "STEP 2 OUT OF 5" : objVMCustomDesign.cutFilterCurrentIndex == 3 ? "STEP 3 OUT OF 5" : objVMCustomDesign.cutFilterCurrentIndex == 4 ?"STEP 4 OUT OF 5" : "STEP 5 OUT OF 5"
        
    }
    func cutFilterValidations() {
        if objVMCustomDesign.cutFilterCurrentIndex == 1 {
            let isShapeSelected =  objVMCustomDesign.productData?.shapesArray?.contains(where: {($0.isSelected ?? true)}) ?? false
            if !isShapeSelected {
                self.view.showToast(Messages.Validation.chooseShape, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
        }
            
        else if objVMCustomDesign.cutFilterCurrentIndex == 2 {
            let isShapeColorSelected =  objVMCustomDesign.productData?.shape_colour?.contains(where: {($0.isSelected ?? true)}) ?? false
            if !isShapeColorSelected {
                self.view.showToast(Messages.Validation.chooseShapeColor, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
        }
            
        else  if objVMCustomDesign.cutFilterCurrentIndex == 3 {
            let isFabricSelected =  objVMCustomDesign.productData?.fabric?.contains(where: {($0.isSelected ?? true)}) ?? false
            if !isFabricSelected {
                self.view.showToast(Messages.Validation.chooseFabric, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
        }
            
        else  if objVMCustomDesign.cutFilterCurrentIndex == 4 {
            let isFabricColorSelected =  objVMCustomDesign.productData?.fabric_colour?.contains(where: {($0.isSelected ?? true)}) ?? false
            if !isFabricColorSelected {
                self.view.showToast(Messages.Validation.chooseFabricColor, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
        }
            
            
        else  if objVMCustomDesign.cutFilterCurrentIndex == 5 {
            let isSewSelected =  objVMCustomDesign.productData?.sew?.contains(where: {($0.isSelected ?? true)}) ?? false
            if !isSewSelected {
                self.view.showToast(Messages.Validation.chooseSew, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
            else {
                bottomCollectionView.isHidden = true
                stackViewStepInfo.isHidden = true
                btnBack.isHidden =  true
                btnNextFilter.isHidden =  true
                self.resetColors()
                self.objVMCustomDesign.selectedFilterOption = -1
                self.objVMCustomDesign.cutFilterCurrentIndex = 1
                unSelectedAllArrays()
                recentShapeAdded = nil
                return
            }
        }
        objVMCustomDesign.cutFilterCurrentIndex =   objVMCustomDesign.cutFilterCurrentIndex + 1
        bottomCollectionView.reloadData()
        handleCutFilterUI()
        
    }
    
    //MARK: SHAPE PRICE
    func calculateShapePrice() {
        let shapeSelctedPrice = objVMCustomDesign.productData?.shapesArray?.first(where: ({$0.isSelected == true}))?.price ?? 0.0
        let fabricSelctedPrice = objVMCustomDesign.productData?.fabric?.first(where: ({$0.isSelected == true}))?.price ?? 0.0
        
        if addedShapesPriceArray.count == 0 {
            addedShapesPriceArray.add(shapeSelctedPrice + fabricSelctedPrice)
        }
        else {
            if recentShapeAdded != nil {
                addedShapesPriceArray.replaceObject(at: addedShapesPriceArray.count - 1, with: shapeSelctedPrice + fabricSelctedPrice)
            }
            else {
                addedShapesPriceArray.add(shapeSelctedPrice + fabricSelctedPrice)
            }
            
        }
        print(addedShapesPriceArray)
        
    }
    //MARK: WHOLE POST PRICE
    func calculateWholePostPrice() -> Double {
        let tShirtPrice = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].price ?? 0.0
        
        let selectedPatternPrice = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.first(where:{$0.isSelected == true})?.price ?? 0.0
        var shapesPrice  = 0.0
        let activeShapesArray = addedShapesPriceArray.filter { ($0 as? Double) != 0.0 }
        for i in 0..<activeShapesArray.count {
            shapesPrice = shapesPrice + (activeShapesArray[i] as? Double ?? 0.0)
        }
        
        let totalPrice = tShirtPrice + selectedPatternPrice + shapesPrice
        print(totalPrice)
        return totalPrice
    }
    
    func nextButtonUIHandling(shouldEnabled:Bool) {
        btnNext.isUserInteractionEnabled = shouldEnabled
        btnNext.alpha = shouldEnabled ? 1.0 : 0.4
    }
    
    func applyPatterAndColorFilter() {
        let clothStyleColorArray = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour ?? []
        
        let selectedPatternIndex =  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.firstIndex(where: {$0.isSelected  == true})
        
        let selectedColorIndex =  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.firstIndex(where:({($0.isSelected == true)}))
        
        outerLoop: for i in 0 ..< clothStyleColorArray.count {
            let clothStyleColorPatternArray = clothStyleColorArray[i].clothStyle_colour_pattern ?? []
            
            for j in 0 ..< clothStyleColorPatternArray.count {
                
                print("current Patterns Id-- \(String(describing: clothStyleColorPatternArray[j].pattern))")
                print("current Color Id-- \(String(describing: clothStyleColorPatternArray[j].id))")
                
                print("---------------------------------------")
                if clothStyleColorPatternArray[j].pattern ?? 0 == objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[selectedPatternIndex ?? 0].id && clothStyleColorPatternArray[j].colour ?? 0 ==  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[selectedColorIndex ?? 0].id {
                    productImage.setSdWebImage(url: clothStyleColorPatternArray[j].image ?? "",isForCustomDesign:true)
                    break outerLoop
                }
                
            }
            
        }
        
    }
    
    func clearPattern() {
        
        let selectedColorIndex = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.firstIndex(where:{$0.isSelected == true})
        productImage.setSdWebImage(url: objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[selectedColorIndex ?? 0].image ?? "",isForCustomDesign:true)
        
    }
    
    
    
    func  selectFilterValidations(sender:UIButton)  {
        if !InternetReachability.sharedInstance.isInternetAvailable() {
            self.view.showToast( Messages.NetworkMessages.noInternetConnection, position: .bottom, popTime: 1.5, dismissOnTap: true)
            return
        }
            
            
        else   if objVMCustomDesign.productSelctedIndex == -1  {
            self.view.showToast(Messages.Validation.chooseProduct, position: .bottom, popTime: 1.5, dismissOnTap: true)
        }
            
        else  if productImage.image == nil {
            self.view.showToast(Messages.Validation.waitForImage, position: .bottom, popTime: 1.5, dismissOnTap: true)
            return
        }
            
        else {
            objVMCustomDesign.selectedFilterOption = sender.tag
            resetColors()
            sender.backgroundColor = AppColors.appColorBlue
            if sender.tag == 3  {
                stackViewStepInfo.isHidden = true
                btnNextFilter.isHidden = true
                btnBack.isHidden = true
                openCameraGalleryPopUp {
                    self.resetColors()
                    self.objVMCustomDesign.selectedFilterOption = -1
                }
                bottomCollectionView.isHidden = true
                return
            }
            bottomCollectionView.reloadData()
            bottomCollectionView.isHidden = false
            bottomCollectionBottomAnchor.constant = sender.tag == 4 ? 5 : -15
            stackViewStepInfo.isHidden = sender.tag == 4 ? false : true
            btnBack.isHidden = sender.tag == 4 ? (objVMCustomDesign.cutFilterCurrentIndex == 1 ? true : false) : true
            btnNextFilter.isHidden = sender.tag == 4 ? false : true
            
            if sender.tag == 4 {
                handleCutFilterUI()
            }
        }
        
    }
    
    func resetColors() {
        for i in stackView.subviews {
            let btn = i as? UIButton
            btn?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                self.saveImageInPhotoGalary(capturedImage: self.screenShotView.screenshot())
            }
            
        case .denied, .restricted :
            DispatchQueue.main.async {
                self.alertForGallaryPermission()
            }
        case .notDetermined:
            print("")
            DispatchQueue.main.async {
                PHPhotoLibrary.requestAuthorization { status in
                    switch status {
                    case .authorized:
                        DispatchQueue.main.async {
                            self.saveImageInPhotoGalary(capturedImage: self.screenShotView.screenshot())
                        }
                        
                    case .denied, .restricted:
                        DispatchQueue.main.async {
                            self.alertForGallaryPermission()
                        }
                    case .notDetermined:
                        print("")
                    @unknown default:
                        print("")
                    }
                }
                
            }
        @unknown default:
            print("")
        }
    }
    
    
}
//MARK: ALL ACTION(S)
extension CustomDesignVC {
    @IBAction func didTapBack(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedNext(_ sender: UIButton) {
        if productImage.image == nil {
            return
        }
        
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.addPostVC) as? AddPostVC
        let imagObject = ColorScheme(colorId: Variables.shared.selectedColorId ?? 0, image: screenShotView.screenshot(),isSelected: Variables.shared.imageColorArray.count == 0 ? true : false)
        Variables.shared.imageColorArray.append(imagObject)
        targetVc?.isFromCustomDesign = true
        targetVc?.minimumPrice =  calculateWholePostPrice()
        self.navigationController?.pushViewController(targetVc ?? UIViewController(), animated: true)
    }
    @IBAction func didTappedPattern(_ sender: UIButton) {
        selectFilterValidations(sender: sender)
    }
    
    @IBAction func didTappedColor(_ sender: UIButton) {
        selectFilterValidations(sender: sender)
    }
    
    @IBAction func didTappedGallary(_ sender: UIButton) {
        selectFilterValidations(sender: sender)
    }
    
    @IBAction func didTappedCut(_ sender: UIButton) {
        
        selectFilterValidations(sender: sender)
    }
    @IBAction func didTappedSave(_ sender: UIButton) {
        if productImage.image == nil {
            self.view.showToast(Messages.Validation.waitForImage, position: .bottom, popTime: 1.5, dismissOnTap: true)
            return
        }
        self.checkPhotoLibraryPermission()
        
    }
    @IBAction func didTappedNextBackFilter(_ sender: UIButton) {
        if sender == btnNextFilter {
            cutFilterValidations()
        }
        else {
            objVMCustomDesign.cutFilterCurrentIndex = objVMCustomDesign.cutFilterCurrentIndex - 1
            bottomCollectionView.reloadData()
            handleCutFilterUI()
        }
    }
    
    @IBAction func didTappedCrossButton(_ sender: UIButton) {
        self.showAlertWithActionAndCancel(message:Messages.DialogMessages.removePatterns) {
            let index:IndexPath = NSIndexPath(item: self.objVMCustomDesign.productSelctedIndex, section: 0) as IndexPath
            self.collectionViewProductList.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            self.objVMCustomDesign.productData?.clothstyle?[self.objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.mutateEach({($0.isSelected = false)})
            self.objVMCustomDesign.productData?.clothstyle?[self.objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.mutateEach({($0.isSelected = false)})
            self.objVMCustomDesign.productSelctedIndex = -1
            self.collectionViewProductList.isHidden = false
            self.screenShotView.isHidden = true
            self.btnDelete.isHidden = true
            self.bottomCollectionView.isHidden = true
            self.btnSaveToGallary.isHidden = true
            self.removeAllObjectsAddedInAvailableFunctionalView()
            self.recentShapeAdded = nil
            self.addedShapesPriceArray.removeAllObjects()
            self.objVMCustomDesign.selectedFilterOption = -1
            self.resetColors()
            self.stackViewStepInfo.isHidden = true
            self.btnNextFilter.isHidden = true
            self.btnBack.isHidden = true
            self.objVMCustomDesign.cutFilterCurrentIndex  = 1
            self.unSelectedAllArrays()
            self.nextButtonUIHandling(shouldEnabled: false)
            
        }
    }
    
}
