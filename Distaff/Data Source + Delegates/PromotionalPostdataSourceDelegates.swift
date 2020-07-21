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
extension PromotionalPostDetailVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  objVMPostDetail.postDetailData?.post_image?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.postImagesCollectionCell, for: indexPath) as? PostImagesCollectionCell
            cell?.postImageView.setSdWebImage(url: objVMPostDetail.postDetailData?.post_image?[indexPath.row].post_images ?? "")
            return cell ?? UICollectionViewCell()
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayZoomSingleImages(url: objVMPostDetail.postDetailData?.post_image?[indexPath.row].post_images ?? "")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (self.view.frame.width), height: 302)
    }
    
}

