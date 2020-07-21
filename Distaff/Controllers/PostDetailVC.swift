//
//  PostDetailVC.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift
import EasyToast

class PostDetailVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var btnSaveToCollection: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var collectionViewSize: UICollectionView!
    @IBOutlet weak var collectionViewColor: UICollectionView!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblClothMaterial: UILabel!
    @IBOutlet weak var imgViewPostCreatedBy: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnCart: MIBadgeButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var addToCartViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var stackViewMessageAndOptions: UIStackView!
    
    //MARK:VARIABLE(S)
    var objVMPostDetail = PostDetailVM()
    var postId:Int?
    var isFromfavourite = false
    var callbackDataRefresh:((_ isPostLiked:Bool,_ commentCount:Int,_ isPostFavourited:Bool,_ likeCount:Int,_ cartCount:String) -> ())?
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showCartCount(btnCart: btnCart)
    }
    
}

//MARK:ALL ACTION(S)
extension PostDetailVC {
    @IBAction func didTappedcartAction(_ sender: UIButton) {
        handleCartButtonSelection(btnCart: btnCart)
        
    }
    @IBAction func didTappedBack(_ sender: UIButton) {
        callbackDataRefresh?(btnLike.isSelected, Int(lblCommentCount.text ?? "0") ?? 0, btnSaveToCollection.isSelected, Int(lblLikeCount.text ?? "0") ?? 0, btnCart.badgeString ?? "")
        PopViewController()
    }
    
    @IBAction func didTappedAddToCart(_ sender: UIButton) {
        if objVMPostDetail.selectedColorIndex != -1 &&  objVMPostDetail.selectedSizeIndex != -1 {
            let request = AddToCart.Request(postId: postId, imageId: objVMPostDetail.postDetailData?.post_image?[objVMPostDetail.selectedColorIndex].id ?? 0, sizeId: objVMPostDetail.postDetailData?.size?[objVMPostDetail.selectedSizeIndex].sizeid ?? 0)
            objVMPostDetail.callAddToCartApi(request) { (data) in
                self.view.showToast(data?.message ?? "Successfully added", position: .bottom, popTime: 2.0, dismissOnTap: true)
                self.btnCart.badgeString = "\(data?.cartCount ?? 0)"
                userdefaultsRef.set( data?.cartCount ?? 0, forKey: UserDefaultsKeys.cartCount)
            }
        }
        
    }
    @IBAction func didTappedMessage(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
        targetVC?.receiverId = objVMPostDetail.postDetailData?.user ?? 0
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    
    @IBAction func didTappedLike(_ sender: UIButton) {
        CommonMethods.callLikeUnlikeApi(postId: postId ?? 0, status: btnLike.isSelected == true ? false : true) {
            let currentCount = (Int(self.lblLikeCount.text ?? "0") ?? 1)
            self.self.lblLikeCount.text = self.btnLike.isSelected == true ? "\(currentCount - 1)" : "\(currentCount + 1)"
            self.btnLike.isSelected = !self.btnLike.isSelected
        }
        
    }
    
    @IBAction func didTappedComment(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.commentsVC) as? CommentsVC
        targetVC?.callBackCommentCount = { totalComments in
            self.lblCommentCount.text = "\(totalComments)"
            
        }
        targetVC?.postId = postId ?? 0
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    
    
    @IBAction func didTappedSavedInCollection(_ sender: UIButton) {
        CommonMethods.callFavouriteUnfavouriteApi(postId: postId ?? 0, status: btnSaveToCollection.isSelected == true ? false : true) {
            self.btnSaveToCollection.isSelected = !self.btnSaveToCollection.isSelected
            if !self.btnSaveToCollection.isSelected && self.isFromfavourite  {
                self.callbackDataRefresh?(self.btnLike.isSelected, Int(self.lblCommentCount.text ?? "0") ?? 0, self.btnSaveToCollection.isSelected, Int(self.lblLikeCount.text ?? "0") ?? 0, self.btnCart.badgeString ?? "")
                self.PopViewController()
            }
            
            
        }
    }
    
    @IBAction func didTappedOptionMenu(_ sender: UIButton) {
        CommonMethods.reportPostOptions { (text) in
            CommonMethods.callReportPostApi(postId: self.postId ?? 0, reason: text) {
                self.showAlert(message: "Post has been reported successfully.")
            }
        }
    }
    
    @IBAction func didTappedUserImage(_ sender: UIButton) {
        
        if  (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 != objVMPostDetail.postDetailData?.user ?? 0
        {
        dismissKeyboard()
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
        targetVC?.isMyProfile = false
        targetVC?.passedUserId = self.objVMPostDetail.postDetailData?.user ?? 0
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
    }
    
    
}
//MARK:ALL METHOD(S)
extension PostDetailVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        objVMPostDetail.callPostDetailApi(view: self.view, url: "\(WebServicesApi.get_post)\(postId ?? 0)") { (data) in
            self.objVMPostDetail.displayPostdetailData(ref: self, data: data)
            
        }
        
    }
    
}
