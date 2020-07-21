//
//  MyFavouriteDataSource.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension MyFavouritesVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFavouriteVM.postListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.homeTableCell) as? HomeTableCell
        cell?.postObject = objFavouriteVM.postListArray[indexPath.row]
        
        cell?.callBackLike = {
            CommonMethods.callLikeUnlikeApi(postId: self.objFavouriteVM.postListArray[indexPath.row].post ?? 0, status: !(self.objFavouriteVM.postListArray[indexPath.row].post_like ?? false)) {
                self.objFavouriteVM.postListArray[indexPath.row].post_like = !(self.objFavouriteVM.postListArray[indexPath.row].post_like ?? false)
                self.objFavouriteVM.postListArray[indexPath.row].total_likes = !(self.objFavouriteVM.postListArray[indexPath.row].post_like ?? false) ?  (self.objFavouriteVM.postListArray[indexPath.row].total_likes ?? 1) - 1 : (self.objFavouriteVM.postListArray[indexPath.row].total_likes ?? 0) + 1
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        
        cell?.callBackSavedInCollection = {
            CommonMethods.callFavouriteUnfavouriteApi(postId: self.objFavouriteVM.postListArray[indexPath.row].post ?? 0, status: !(self.objFavouriteVM.postListArray[indexPath.row].post_fav ?? false)) {
                self.objFavouriteVM.postListArray.remove(at: indexPath.row)
                tableView.reloadData()
                self.tblViewfavourites.showNoDataLabel(message:Messages.NoDataMessage.noFavouritePost, arrayCount: self.objFavouriteVM.postListArray.count)
            }
        }
        
        cell?.callBackProfileTapped = {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
            targetVC?.isMyProfile = false
            targetVC?.passedUserId = self.objFavouriteVM.postListArray[indexPath.row].user ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        
        cell?.callBackBuy = {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.postDetailVC) as? PostDetailVC
            targetVC?.isFromfavourite = true
            targetVC?.postId = self.objFavouriteVM.postListArray[indexPath.row].post ?? 0
            targetVC?.callbackDataRefresh = {isPostLiked, commentCount, isPostFavourited, likeCount,cartCount in
                self.objFavouriteVM.postListArray[indexPath.row].post_like = isPostLiked
                self.objFavouriteVM.postListArray[indexPath.row].total_comments = commentCount
                
                self.objFavouriteVM.postListArray[indexPath.row].total_likes = likeCount
                self.objFavouriteVM.postListArray[indexPath.row].post_fav = isPostFavourited
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            
            
            
        }
        
        
        cell?.callBackComment = {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.commentsVC) as? CommentsVC
            targetVC?.callBackCommentCount = { totalComments in
                self.objFavouriteVM.postListArray[indexPath.row].total_comments = totalComments
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            targetVC?.postId = self.objFavouriteVM.postListArray[indexPath.row].post ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            
        }
        
        cell?.callBackMessage = {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
            targetVC?.receiverId = self.objFavouriteVM.postListArray[indexPath.row].user ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            
        }
        cell?.callBackMenuOptions  = {
            CommonMethods.reportPostOptions { (text) in
                CommonMethods.callReportPostApi(postId: self.objFavouriteVM.postListArray[indexPath.row].post ?? 0, reason: text) {
                    self.showAlert(message: "Post has been reported successfully.")
                    
                }
                
            }
        }
        
        return cell ?? UITableViewCell()
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if objFavouriteVM.postListArray[indexPath.row].post_type != "promotional" {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.postDetailVC) as? PostDetailVC
            targetVC?.postId = self.objFavouriteVM.postListArray[indexPath.row].post ?? 0
            targetVC?.isFromfavourite = true
            targetVC?.callbackDataRefresh = {isPostLiked, commentCount, isPostFavourited, likeCount,cartCount in
                if !isPostFavourited {
                    self.objFavouriteVM.postListArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    self.tblViewfavourites.showNoDataLabel(message: Messages.NoDataMessage.noFavouritePost, arrayCount: self.objFavouriteVM.postListArray.count)
                    return
                }
                
                self.objFavouriteVM.postListArray[indexPath.row].post_like = isPostLiked
                self.objFavouriteVM.postListArray[indexPath.row].total_comments = commentCount
                self.objFavouriteVM.postListArray[indexPath.row].total_likes = likeCount
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
            
        else {
            
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.promotionalPostDetailVC) as? PromotionalPostDetailVC
            targetVC?.postId = self.objFavouriteVM.postListArray[indexPath.row].post ?? 0
            targetVC?.isFromfavourite = true
            targetVC?.callbackDataRefresh = {isPostLiked, commentCount, isPostFavourited, likeCount in
                if !isPostFavourited {
                    self.objFavouriteVM.postListArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    self.tblViewfavourites.showNoDataLabel(message: Messages.NoDataMessage.noFavouritePost, arrayCount: self.objFavouriteVM.postListArray.count)
                    return
                }
                
                self.objFavouriteVM.postListArray[indexPath.row].post_like = isPostLiked
                self.objFavouriteVM.postListArray[indexPath.row].total_comments = commentCount
                self.objFavouriteVM.postListArray[indexPath.row].total_likes = likeCount
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
            
            
        }
        
        
    }
    
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if indexPath.row == objFavouriteVM.postListArray.count - 1 && objFavouriteVM.doesNxtPageExist {
    //            print("----------------------------- Api Called --------------------------")
    //            objFavouriteVM.pageNumber =  objFavouriteVM.pageNumber + 1
    //            objFavouriteVM.callFavouriteListsApi(refreshControl: refreshControl, shouldAnimate: true) { (data) in
    //                self.tblViewfavourites.reloadData()
    //            }
    //
    //        }
    //
    //
    //    }
    
    
}


