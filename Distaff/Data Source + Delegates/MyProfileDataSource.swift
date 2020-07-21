//
//  MyProfileDataSource.swift
//  Distaff
//
//  Created by netset on 16/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:COLLECTION DATA SOURCE(S)
extension MyProfileVC :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if objProfileVM.cellType == 0  {
            return objProfileVM.profileData?.data?.post_images?.count ?? 0
        }
            
        else   if objProfileVM.cellType == 1  {
            return objProfileVM.followListFilterArray.count
        }
        
        return objProfileVM.followingListFilterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if objProfileVM.cellType == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.myProfileGridCell, for: indexPath) as? MyProfileGridCell
            let image = cell?.viewWithTag(10) as? UIImageView
            image?.setSdWebImage(url: objProfileVM.profileData?.data?.post_images?[indexPath.row].post_image ?? "")
            return cell ?? UICollectionViewCell()
        }
            
        else if  objProfileVM.cellType == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.myprofileListCell, for: indexPath) as? MyprofileListCell
            cell?.profilePic.setSdWebImage(url: objProfileVM.followListFilterArray[indexPath.row].image ?? "")
            cell?.lbloFullName.text = objProfileVM.followListFilterArray[indexPath.row].fullname ?? ""
            cell?.lblUserName.text = objProfileVM.followListFilterArray[indexPath.row].user_name ?? ""
            cell?.btnFollow.setTitle(objProfileVM.followListFilterArray[indexPath.row].follow_status == true ? "FOLLOWING" : "FOLLOW", for: .normal)
            cell?.btnFollow.isHidden =  objProfileVM.followListFilterArray[indexPath.row].follow_by == (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 ? true : false
            
            cell?.callBackFollowUnfollow = {
                let status = !(self.objProfileVM.followListFilterArray[indexPath.row].follow_status ?? false)
                CommonMethods.callFollowUnFollowApi(follow_to: self.objProfileVM.followListFilterArray[indexPath.row].follow_by ?? 0, followStatus: status == true ? 1 : 0) {
                    self.objProfileVM.followListFilterArray[indexPath.row].follow_status = status
                    let index_FollowArray =  self.objProfileVM.followListArray.firstIndex(where: {($0.id ?? 0 == self.objProfileVM.followListFilterArray[indexPath.row].id ?? 0)})
                     self.objProfileVM.followListArray[index_FollowArray ?? 0].follow_status = status
                    self.collectionViewPosts.reloadItems(at: [indexPath])
                    if self.isMyProfile {
                        let count = Int(self.lblFollowingCount.text ?? "1")
                        self.lblFollowingCount.text = status == true ? "\((count ?? 0) + 1)" : "\((count ?? 1) - 1)"
                    }
                }
            }
            return cell ?? UICollectionViewCell()
        }
            
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CellIdentifers.myprofileListCell, for: indexPath) as? MyprofileListCell
            cell?.profilePic.setSdWebImage(url: objProfileVM.followingListFilterArray[indexPath.row].image ?? "")
            cell?.lbloFullName.text = objProfileVM.followingListFilterArray[indexPath.row].fullname ?? ""
            cell?.lblUserName.text = objProfileVM.followingListFilterArray[indexPath.row].user_name ?? ""
            cell?.btnFollow.setTitle(objProfileVM.followingListFilterArray[indexPath.row].follow_status == true ? "FOLLOWING" : "FOLLOW", for: .normal)
            
            cell?.btnFollow.isHidden =  objProfileVM.followingListFilterArray[indexPath.row].follow_to == (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.id ?? 0 ? true : false
            
            cell?.callBackFollowUnfollow = {
                let status = !(self.objProfileVM.followingListFilterArray[indexPath.row].follow_status ?? false)
                CommonMethods.callFollowUnFollowApi(follow_to: self.objProfileVM.followingListFilterArray[indexPath.row].follow_to ?? 0, followStatus: status == true ? 1 : 0) {
                    if self.isMyProfile {
                        let index_FollowingArray =  self.objProfileVM.followingListArray.firstIndex(where: {($0.id ?? 0 == self.objProfileVM.followingListFilterArray[indexPath.row].id ?? 0)})
                        self.objProfileVM.followingListArray.remove(at: index_FollowingArray ?? 0)
                        self.objProfileVM.followingListFilterArray.remove(at: indexPath.row)
                        self.collectionViewPosts.reloadData()
                        self.collectionViewPosts.showNoDataLabel(message:Messages.NoDataMessage.noFollowing, arrayCount: self.objProfileVM.followingListFilterArray.count)
                        self.lblFollowingCount.text = "\(self.objProfileVM.followingListArray.count)"
                    }
                        
                    else {
                         let index_FollowingArray =  self.objProfileVM.followingListArray.firstIndex(where: {($0.id ?? 0 == self.objProfileVM.followingListFilterArray[indexPath.row].id ?? 0)})
                        self.objProfileVM.followingListArray[index_FollowingArray ?? 0].follow_status = status
                        self.objProfileVM.followingListFilterArray[indexPath.row].follow_status = status
                        self.collectionViewPosts.reloadItems(at: [indexPath])
                    }
                    
                }
                
            }
            
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionViewHeightAnchor.constant = collectionView.contentSize.height
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  objProfileVM.cellType == 0 ? .init(width: (self.view.frame.width   / 3)  , height: self.view.frame.width / 3) :.init(width: (self.view.frame.width), height: 83)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if objProfileVM.cellType == 0 {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.postDetailVC) as? PostDetailVC
            targetVC?.postId = self.objProfileVM.profileData?.data?.post_images?[indexPath.row].post ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        
        
    }
    
    
}
