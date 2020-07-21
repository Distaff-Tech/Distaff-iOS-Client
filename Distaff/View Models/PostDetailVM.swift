//
//  PostDetailVM.swift
//  Distaff
//
//  Created by netset on 20/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class PostDetailVM {
    
    var postDetailData:PostData?
    
    var selectedColorIndex = -1
    var selectedSizeIndex = -1
    
    func callPostDetailApi(view:UIView,url:String,_completion:@escaping(_ data:PostData?) -> Void) {
        view.handleVisibility(shouldHide: true)
        Services.getRequest(url: url, shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(PostDetailModel.self, from: responseData)
                self.postDetailData = data.data
                 view.handleVisibility(shouldHide: false)
                _completion(data.data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    func callAddToCartApi(_ request: AddToCart.Request,_completion:@escaping(_ data:AddToCartModel?) -> Void) {
        Services.postRequest(url: WebServicesApi.addToCart, param: [Add_Cart.post_id:request.postId ?? "0",Add_Cart.image_id:request.imageId ?? "0",Add_Cart.size_id : request.sizeId ?? 0], shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(AddToCartModel.self, from: responseData)
                _completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    
    func displayPostdetailData(ref:PostDetailVC,data:PostData?) {
        selectedColorIndex = 0
        selectedSizeIndex = 0
        ref.collectionViewImages.reloadData()
        ref.collectionViewColor.reloadData()
        ref.collectionViewSize.reloadData()
        ref.btnLike.isSelected = data?.post_like ?? false
        ref.lblLikeCount.text = "\(data?.total_likes ?? 0)"
        ref.lblCommentCount.text = "\(data?.total_comments ?? 0)"
        ref.btnSaveToCollection.isSelected = data?.post_fav ?? false
        ref.lblPrice.text = "\("$")\(data?.price ?? "0")"
        ref.lblDescription.text = data?.post_description ?? ""
        ref.lblClothMaterial.text = data?.fabric?[0].fabric_name ?? ""
        ref.lblFullName.text = data?.fullname ?? ""
        ref.lblAddress.text = data?.address ?? ""
        ref.imgViewPostCreatedBy.setSdWebImage(url: data?.image ?? "")
        ref.pageControl.numberOfPages = data?.post_image?.count ?? 0
        ref.btnCart.badgeString = data?.cartCount == 0 ? "" : "\(data?.cartCount ?? 0)"
        ref.addToCartViewHeightAnchor.constant = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 == data?.user ?? 0 ? 0  : 65
        ref.btnAddToCart.isHidden = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 == data?.user ?? 0 ? true  : false
        
        ref.stackViewMessageAndOptions.isHidden = ref.btnAddToCart.isHidden
        
    }
    
    
    
    func displayPromotionalPostdetailData(ref:PromotionalPostDetailVC,data:PostData?) {
        ref.collectionViewImages.reloadData()
        ref.btnLike.isSelected = data?.post_like ?? false
        ref.lblLikeCount.text = "\(data?.total_likes ?? 0)"
        ref.lblCommentCount.text = "\(data?.total_comments ?? 0)"
        ref.btnSaveToCollection.isSelected = data?.post_fav ?? false
        ref.txtViewDescription.text = data?.post_description
        
        
    }
    
    
}



