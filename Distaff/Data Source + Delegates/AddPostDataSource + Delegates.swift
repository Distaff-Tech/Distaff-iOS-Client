//
//  AddPostDataSource + Delegates.swift
//  Distaff
//
//  Created by netset on 11/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:COLLECTION VIEW DATA SOURCE(S)
extension AddPostVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == collectionViewSize ? Variables.shared.sizeListArray.count : Variables.shared.imageColorArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewSize {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.clothSizeCollectionCell, for: indexPath) as? ClothSizeCollectionCell
            cell?.sizeObj = Variables.shared.sizeListArray[indexPath.row]
            return cell ?? UICollectionViewCell()
        }
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.clothColorCollectionCell, for: indexPath) as? ClothColorCollectionCell
            
            cell?.imgViewColor.image = indexPath.row == Variables.shared.imageColorArray.count ? #imageLiteral(resourceName: "plus") : Variables.shared.imageColorArray[indexPath.row].image
            cell?.btnDelete.isHidden = indexPath.row == Variables.shared.imageColorArray.count ? true : false
            
            cell?.layer.borderWidth = indexPath.row != Variables.shared.imageColorArray.count && Variables.shared.imageColorArray[indexPath.row].isSelected == true ? 1.0 :0.0
            
            cell?.layer.borderColor = indexPath.row != Variables.shared.imageColorArray.count && Variables.shared.imageColorArray[indexPath.row].isSelected == true ? AppColors.appColorBlue.cgColor : UIColor.white.cgColor
            
            cell?.callBackDelete = {
                if Variables.shared.imageColorArray[indexPath.row].isSelected ?? false {
                    
                    if Variables.shared.imageColorArray.count > 1 {
                        if indexPath.row == 0 {
                            self.imgViewPostImage.image =   Variables.shared.imageColorArray[indexPath.row + 1].image
                            
                            self.reflectColorSelectedArray(indexPath: indexPath.row + 1)
                            
                        }
                        else {
                            self.imgViewPostImage.image =   Variables.shared.imageColorArray[indexPath.row - 1].image
                            self.reflectColorSelectedArray(indexPath: indexPath.row - 1)
                        }
                    }
                    else {
                        self.imgViewPostImage.image = Variables.shared.placeholderImage
                    }
                    
                }
                
                Variables.shared.imageColorArray.remove(at: indexPath.row)
                collectionView.reloadData()
                if Variables.shared.imageColorArray.count == 0 {
                    self.imgViewPostImage.image = Variables.shared.placeholderImage
                    
                    if self.isFromCustomDesign {
                        self.objVMAddPost.definedMinimumPrice = self.serverMinimumPrice
                    }
                }
                
                
            }
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  collectionView == collectionViewSize ? .init(width: 50  , height: 50) :.init(width: (70), height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewSize {
            Variables.shared.sizeListArray[indexPath.row].isSelected =  !(Variables.shared.sizeListArray[indexPath.row].isSelected ?? false)
            
            collectionViewSize.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.reloadData()
        }
        else {
            if indexPath.row == Variables.shared.imageColorArray.count {
                if Variables.shared.imageColorArray.count < 5 {
                    openCameraGalleryPopUp()
                }
                    
                else {
                    self.showAlert(message:Messages.Validation.uploadMaximumImage)
                }
            }
                
            else {
                imgViewPostImage.image = Variables.shared.imageColorArray[indexPath.row].image
                reflectColorSelectedArray(indexPath: indexPath.row)
            }
        }
        
        
    }
    
}
