//
//  CustomDesignmDataSource + Deletgates.swift
//  Distaff
//
//  Created by Aman on 13/04/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK: COLLECTION DELEGATE METHOD(S)
extension CustomDesignVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewProductList {
            return objVMCustomDesign.productData?.clothstyle?.count ?? 0
        }
        else  {
            if objVMCustomDesign.selectedFilterOption == 1 {
                return objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.count ?? 0
            }
                
            else if objVMCustomDesign.selectedFilterOption == 2 {
                return objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.count ?? 0
            }
            else if objVMCustomDesign.cutFilterCurrentIndex == 1 {
                return  objVMCustomDesign.productData?.shapesArray?.count ?? 0
            }
            else if objVMCustomDesign.cutFilterCurrentIndex == 2 {
                return  objVMCustomDesign.productData?.shape_colour?.count ?? 0
            }
            else if objVMCustomDesign.cutFilterCurrentIndex == 3 {
                return  objVMCustomDesign.productData?.fabric?.count ?? 0
            }
            else if objVMCustomDesign.cutFilterCurrentIndex == 4 {
                return  objVMCustomDesign.productData?.fabric_colour?.count ?? 0
            }
            return  objVMCustomDesign.productData?.sew?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewProductList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignListCollectionCell, for: indexPath) as? CustomDesignListCollectionCell
            
            DispatchQueue.main.async {
                cell?.setNeedsLayout()
                cell?.layoutIfNeeded()
            }
            cell?.productImage.setSdWebImage(url:objVMCustomDesign.productData?.clothstyle?[indexPath.row].clothStyle_Colour?[0].image ?? "",isForCustomDesign:true)
            
            return cell ?? UICollectionViewCell()
        }
            
        else {
            
            if objVMCustomDesign.selectedFilterOption == 1 {
                
                if indexPath.row == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignSewCell, for: indexPath) as? CustomDesignSewCell
                    cell?.lblSew.text = "None"
                    cell?.lblSew.borderColor = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray
                    cell?.lblSew.textColor = cell?.lblSew.borderColor
                    return cell ?? UICollectionViewCell()
                }
                    
                else  {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.patternCollectionViewCell, for: indexPath) as? PatternCollectionViewCell
                    cell?.imageViewpattern.setSdWebImage(url: objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].image ?? "")
                    cell?.imageViewpattern.borderColor =  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray
                    
                    cell?.imageViewpattern.borderWidth =  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].isSelected ?? false ? 1.5 : 1
                    return cell ?? UICollectionViewCell()
                }
            }
                
            else if objVMCustomDesign.selectedFilterOption == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignChooseColorCollectionCell, for: indexPath) as? CustomDesignChooseColorCollectionCell
                cell?.colorView.backgroundColor = UIColor(hexFromString: objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].colour_code ?? "")
                
                cell?.colorOuterView.borderWidth = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].isSelected ?? false ? 1.5 : 1
                
                cell?.colorOuterView.borderColor =  objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray
                
                return cell ?? UICollectionViewCell()
            }
                
            else if objVMCustomDesign.cutFilterCurrentIndex == 1 || objVMCustomDesign.cutFilterCurrentIndex == 3 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignShapeCell, for: indexPath) as? CustomDesignShapeCell
                cell?.imageHeightAnchor.constant = objVMCustomDesign.cutFilterCurrentIndex == 1 ? 32 : 38
                cell?.imgViewShape.contentMode = objVMCustomDesign.cutFilterCurrentIndex == 1 ? .scaleAspectFit : .scaleAspectFill
                cell?.imgViewShape.cornerRadius = objVMCustomDesign.cutFilterCurrentIndex == 1 ? 0 : 19
                cell?.selectedView.borderWidth =  objVMCustomDesign.cutFilterCurrentIndex == 1 ? (objVMCustomDesign.productData?.shapesArray?[indexPath.row].isSelected ?? false ? 1.5 : 1) : (objVMCustomDesign.productData?.fabric?[indexPath.row].isSelected ?? false ? 1.5 : 1)
                
                cell?.selectedView.borderColor = objVMCustomDesign.cutFilterCurrentIndex == 1 ? (objVMCustomDesign.productData?.shapesArray?[indexPath.row].isSelected ?? false  ? AppColors.appColorBlue : .lightGray) : (objVMCustomDesign.productData?.fabric?[indexPath.row].isSelected ?? false  ? AppColors.appColorBlue : .lightGray)
                
                cell?.imgViewShape.setSdWebImage(url: objVMCustomDesign.cutFilterCurrentIndex == 1 ? objVMCustomDesign.productData?.shapesArray?[indexPath.row].image ?? "" : objVMCustomDesign.productData?.fabric?[indexPath.row].image ?? "")
                
                
                cell?.lblShapeName.text =  objVMCustomDesign.cutFilterCurrentIndex == 1 ? objVMCustomDesign.productData?.shapesArray?[indexPath.row].shapeName ?? "" : objVMCustomDesign.productData?.fabric?[indexPath.row].fabric ?? ""
                return cell ?? UICollectionViewCell()
                
            }
                
            else  if objVMCustomDesign.cutFilterCurrentIndex == 2 || objVMCustomDesign.cutFilterCurrentIndex == 4  {
                
                if objVMCustomDesign.cutFilterCurrentIndex == 4 && indexPath.row == 0 {
                    
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignSewCell, for: indexPath) as? CustomDesignSewCell
                    cell?.lblSew.text = "None"
                    cell?.lblSew.borderColor = objVMCustomDesign.productData?.fabric_colour?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray
                    cell?.lblSew.textColor = cell?.lblSew.borderColor
                    return cell ?? UICollectionViewCell()
                    
                }
                    
                else  {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignChooseColorCollectionCell, for: indexPath) as? CustomDesignChooseColorCollectionCell
                    
                    cell?.colorView.backgroundColor = objVMCustomDesign.cutFilterCurrentIndex == 2 ? UIColor(hexFromString: objVMCustomDesign.productData?.shape_colour?[indexPath.row].colour ?? "") : UIColor(hexFromString: objVMCustomDesign.productData?.fabric_colour?[indexPath.row].colour_code ?? "")
                    
                    cell?.colorOuterView.borderWidth =  objVMCustomDesign.cutFilterCurrentIndex == 2 ? (objVMCustomDesign.productData?.shape_colour?[indexPath.row].isSelected ?? false ? 1.5 : 1) : (objVMCustomDesign.productData?.fabric_colour?[indexPath.row].isSelected ?? false ? 1.5 : 1)
                    
                    cell?.colorOuterView.borderColor =  objVMCustomDesign.cutFilterCurrentIndex == 2 ? (objVMCustomDesign.productData?.shape_colour?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray) : (objVMCustomDesign.productData?.fabric_colour?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray)
                    return cell ?? UICollectionViewCell()
                }
            }
                
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.customDesignSewCell, for: indexPath) as? CustomDesignSewCell
                cell?.lblSew.text = objVMCustomDesign.productData?.sew?[indexPath.row].sew_name ?? ""
                cell?.lblSew.borderColor = objVMCustomDesign.productData?.sew?[indexPath.row].isSelected ?? false ? AppColors.appColorBlue : .lightGray
                cell?.lblSew.textColor = cell?.lblSew.borderColor
                return cell ?? UICollectionViewCell()
                
            }
            
        }
        
    }
    
    func makePatternSlectedAfterproductSelection() {
        let patternsBtn = stackView.viewWithTag(1) as? UIButton
        objVMCustomDesign.selectedFilterOption = 1
        resetColors()
        patternsBtn?.backgroundColor = AppColors.appColorBlue
        bottomCollectionView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewProductList {
            let centreIndex = collectionView.centerCellIndexPath
            if centreIndex  == indexPath {
                makePatternSlectedAfterproductSelection()
                objVMCustomDesign.productSelctedIndex = indexPath.row
                self.collectionViewProductList.isHidden = true
                self.screenShotView.isHidden = false
                self.productImage.setSdWebImage(url: objVMCustomDesign.productData?.clothstyle?[indexPath.row].clothStyle_Colour?[0].image ?? "",isForCustomDesign:true)
                self.btnSaveToGallary.isHidden = false
                objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[0].isSelected  = true
                objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[0].isSelected = true
                
                bottomCollectionView.reloadData()
                btnDelete.isHidden = false
            }
            else {
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
            
        else  {
            
            if !InternetReachability.sharedInstance.isInternetAvailable() {
                self.view.showToast( Messages.NetworkMessages.noInternetConnection, position: .bottom, popTime: 1.5, dismissOnTap: true)
                return
            }
            
            if objVMCustomDesign.selectedFilterOption == 1 {
                
                if !(objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].isSelected ?? false) {
                    objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?[indexPath.row].isSelected = true
                    
                    bottomCollectionView.reloadData()
                    if indexPath.row == 0 {
                        clearPattern()
                        nextButtonUIHandling(shouldEnabled: false)
                    }
                        
                    else {
                        nextButtonUIHandling(shouldEnabled: true)
                        applyPatterAndColorFilter()
                        
                    }
                    
                    
                }
                
            }
            else  if objVMCustomDesign.selectedFilterOption == 2 {
                
                if  !(objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].isSelected ?? false) {
                    
                    objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].isSelected  = true
                    
                    bottomCollectionView.reloadData()
                    
                    let isPatternsSelected = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.contains(where:({$0.isSelected == true}))
                    
                    
                    let selectedPatternIndex = objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_pattern?.firstIndex(where:{$0.isSelected == true})
                    
                    if !(isPatternsSelected ?? false)  || selectedPatternIndex == 0  {
                        productImage.setSdWebImage(url: objVMCustomDesign.productData?.clothstyle?[objVMCustomDesign.productSelctedIndex].clothStyle_Colour?[indexPath.row].image ?? "",isForCustomDesign:true)
                    }
                        
                    else  {
                        applyPatterAndColorFilter()
                        
                    }
                }
                
            }
                
            else if  objVMCustomDesign.cutFilterCurrentIndex == 1 {
                if !(objVMCustomDesign.productData?.shapesArray?[indexPath.row].isSelected ?? false) {
                    objVMCustomDesign.productData?.shapesArray?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.shapesArray?[indexPath.row].isSelected = true
                    objVMCustomDesign.productData?.shape_colour?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.fabric?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.fabric_colour?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.sew?.mutateEach({($0.isSelected = false)})
                    nextButtonUIHandling(shouldEnabled: true)
                    bottomCollectionView.reloadData()
                    calculateShapePrice()
                    createParticularShapeWithFabric(index: indexPath.row, productImage: productImage)
                }
            }
                
            else if  objVMCustomDesign.cutFilterCurrentIndex == 2 {
                if !(objVMCustomDesign.productData?.shape_colour?[indexPath.row].isSelected ?? false) {
                    objVMCustomDesign.productData?.shape_colour?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.shape_colour?[indexPath.row].isSelected = true
                    bottomCollectionView.reloadData()
                    bottomCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    recentShapeAdded?.borderColor = UIColor.init(hexFromString: objVMCustomDesign.productData?.shape_colour?[indexPath.row].colour ?? "")
                }
            }
            else if  objVMCustomDesign.cutFilterCurrentIndex == 3 {
                if !(objVMCustomDesign.productData?.fabric?[indexPath.row].isSelected ?? false) {
                    objVMCustomDesign.productData?.fabric?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.fabric?[indexPath.row].isSelected = true
                    bottomCollectionView.reloadData()
                    bottomCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    
                    let selectedFabricColorIndex = objVMCustomDesign.productData?.fabric_colour?.firstIndex(where: {$0.isSelected == true})
                    
                    if selectedFabricColorIndex == 0  || selectedFabricColorIndex  == nil {  // check if fabric color select
                        guard let fabricImageView = recentShapeAdded?.viewWithTag(5) as? UIImageView else {
                            return
                        }
                        fabricImageView.setSdWebImage(url: objVMCustomDesign.productData?.fabric?[indexPath.row].image ?? "", isForCustomDesign: true)
                    }
                    else {
                        let selectedFabricId = objVMCustomDesign.productData?.fabric?.first(where: {$0.isSelected == true})?.id ?? 0
                        
                        let selectedFabricColorId = objVMCustomDesign.productData?.fabric_colour?.first(where: {$0.isSelected == true})?.id ?? 0
                        
                        let fabricColorImagesArray = objVMCustomDesign.productData?.fabric_colour?.first(where:{$0.id == selectedFabricColorId})?.fabric_Colour_images
                        
                        let fabricImage = fabricColorImagesArray?.first(where: {$0.fabric == selectedFabricId && $0.fabriccolour == selectedFabricColorId})?.image
                        
                        guard let fabricImageView = recentShapeAdded?.viewWithTag(5) as? UIImageView else {
                            return
                        }
                        fabricImageView.setSdWebImage(url: fabricImage ?? "", isForCustomDesign: true)
                    }
                    
                }
                calculateShapePrice()
            }
                
            else if  objVMCustomDesign.cutFilterCurrentIndex == 4 {
                if !(objVMCustomDesign.productData?.fabric_colour?[indexPath.row].isSelected ?? false) {
                    
                    objVMCustomDesign.productData?.fabric_colour?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.fabric_colour?[indexPath.row].isSelected = true
                    bottomCollectionView.reloadData()
                    
                    guard let fabricImageView = recentShapeAdded?.viewWithTag(5) as? UIImageView else {
                        return
                    }
                    
                    if indexPath.row == 0 {
                        let selectedFabricIndex = objVMCustomDesign.productData?.fabric?.firstIndex(where: {$0.isSelected == true})
                        
                        fabricImageView.setSdWebImage(url: objVMCustomDesign.productData?.fabric?[selectedFabricIndex ?? 0].image ?? "", isForCustomDesign: true)
                        
                    }
                    else {
                        let selectedFabricId = objVMCustomDesign.productData?.fabric?.first(where:{$0.isSelected == true})?.id ?? 0
                        let fabricImage = objVMCustomDesign.productData?.fabric_colour?[indexPath.row].fabric_Colour_images?.first(where:{$0.fabric == selectedFabricId})?.image
                        fabricImageView.setSdWebImage(url: fabricImage ?? "", isForCustomDesign: true)
                    }
                }
            }
                
            else {
                
                if !(objVMCustomDesign.productData?.sew?[indexPath.row].isSelected ?? false) {
                    objVMCustomDesign.productData?.sew?.mutateEach({($0.isSelected = false)})
                    objVMCustomDesign.productData?.sew?[indexPath.row].isSelected = true
                    bottomCollectionView.reloadData()
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
