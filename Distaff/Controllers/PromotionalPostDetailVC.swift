//
//  PromotionalPostDetailVC.swift
//  Distaff
//
//  Created by Aman on 06/05/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class PromotionalPostDetailVC: BaseClass {

    @IBOutlet weak var btnSaveToCollection: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var txtViewDescription: UITextView!
    
    
    //MARK:VARIABLE(S)
    var objVMPostDetail = PostDetailVM()
    var postId:Int?
    var isFromfavourite = false
    var callbackDataRefresh:((_ isPostLiked:Bool,_ commentCount:Int,_ isPostFavourited:Bool,_ likeCount:Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       prepareUI()
    }
    

}

    
//MARK:ALL ACTION(S)
    extension PromotionalPostDetailVC {
        @IBAction func didTappedBack(_ sender: UIButton) {
           callbackDataRefresh?(btnLike.isSelected, Int(lblCommentCount.text ?? "0") ?? 0, btnSaveToCollection.isSelected, Int(lblLikeCount.text ?? "0") ?? 0)
            PopViewController()
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
                   self.callbackDataRefresh?(self.btnLike.isSelected, Int(self.lblCommentCount.text ?? "0") ?? 0, self.btnSaveToCollection.isSelected, Int(self.lblLikeCount.text ?? "0") ?? 0)
                    self.PopViewController()
                }
                
                
            }
        }
        
}
//MARK:ALL METHOD(S)
extension PromotionalPostDetailVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        objVMPostDetail.callPostDetailApi(view: self.view, url: "\(WebServicesApi.get_post)\(postId ?? 0)") { (data) in
            self.objVMPostDetail.displayPromotionalPostdetailData(ref: self, data: data)
            
        }
        
        
    }
    
}
