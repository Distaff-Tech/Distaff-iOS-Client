//
//  PostDetailDataSource + Delgates.swift
//  Distaff
//
//  Created by netset on 20/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser


//MARK:COLLECTION DATA SOURCE(S)
extension PostDetailVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == collectionViewSize ? (objVMPostDetail.postDetailData?.size?.count ?? 0) : collectionView == collectionViewColor ? (objVMPostDetail.postDetailData?.post_image_colour?.count ?? 0) :objVMPostDetail.postDetailData?.post_image?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewSize {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.clothSizeCollectionCell, for: indexPath) as? ClothSizeCollectionCell
            cell?.lblSize.text = objVMPostDetail.postDetailData?.size?[indexPath.row].size_name
            cell?.lblSize.textColor = objVMPostDetail.selectedSizeIndex == indexPath.row ? .white : AppColors.appColorBlue
            cell?.lblSize.backgroundColor = objVMPostDetail.selectedSizeIndex == indexPath.row ? AppColors.appColorBlue : .white
            return cell ?? UICollectionViewCell()
        }
        else if collectionView == collectionViewColor   {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.clothColorCollectionCell, for: indexPath) as? ClothColorCollectionCell
            cell?.imgViewColor.setSdWebImage(url: objVMPostDetail.postDetailData?.post_image?[indexPath.row].post_images ?? "")
            cell?.layer.borderWidth = indexPath.row == objVMPostDetail.selectedColorIndex ? 1.0 :0.0
            return cell ?? UICollectionViewCell()
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.postImagesCollectionCell, for: indexPath) as? PostImagesCollectionCell
            cell?.postImageView.setSdWebImage(url: objVMPostDetail.postDetailData?.post_image?[indexPath.row].post_images ?? "")
            return cell ?? UICollectionViewCell()
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewSize {
            objVMPostDetail.selectedSizeIndex = indexPath.row
            collectionViewSize.reloadData()
        }
        else if collectionView == collectionViewColor {
            objVMPostDetail.selectedColorIndex = indexPath.row
            collectionViewImages.scrollToItem(at: NSIndexPath(row: objVMPostDetail.selectedColorIndex, section: 0) as IndexPath, at: .left, animated: true)
            self.pageControl?.currentPage = indexPath.row
            collectionViewColor.reloadData()
        }
            
        else {
            var images = [SKPhotoProtocol]()
            for i in 0 ... (objVMPostDetail.postDetailData?.post_image?.count ?? 1) - 1 {
                let image = objVMPostDetail.postDetailData?.post_image?[i].post_images ?? ""
                let photo = SKPhoto.photoWithImageURL("\(WebServicesApi.imageBaseUrl)\(image)")
                photo.shouldCachePhotoURLImage = true
                images.append(photo)
            }
            displayZoomImages(imageArray: images, index: indexPath.row)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  collectionView == collectionViewSize ? .init(width: 50  , height: 50) : collectionView == collectionViewColor ? .init(width: (70), height: 60) : .init(width: (self.view.frame.width), height: 302)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionViewImages {
            let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
            let index = scrollView.contentOffset.x / witdh
            let roundedIndex = round(index)
            self.pageControl?.currentPage = Int(roundedIndex)
            objVMPostDetail.selectedColorIndex = Int(roundedIndex)
            collectionViewColor.reloadData()
        }
        
    }
    
}

