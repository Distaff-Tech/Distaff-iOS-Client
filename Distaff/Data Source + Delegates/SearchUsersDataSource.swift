//
//  SearchPostDataSource.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension SearchUserVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objSearchVM.serachUsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.searchTableViewCell) as? SearchTableViewCell
        cell?.serachUser = objSearchVM.serachUsersArray[indexPath.row]
        cell?.callBackProfileTapped = {
           
            if #available(iOS 13.0, *) {
                      self.searchBarController.searchTextField.endEditing(true)
                  }
                  else {
                let textFieldInsideUISearchBar = self.searchBarController.value(forKey: "_searchField") as? UITextField
                textFieldInsideUISearchBar?.endEditing(true)
            }
            
            
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
            targetVC?.isMyProfile = false
            targetVC?.passedUserId = self.objSearchVM.serachUsersArray[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == objSearchVM.serachUsersArray.count - 1 && objSearchVM.totalPage ?? 0 >  objSearchVM.pageNumber  {
            objSearchVM.pageNumber = objSearchVM.pageNumber + 1
            fetchListOfUsers(shouldAnimate: true)
        }
    }
    
    
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        if scrollView == tblViewSearch {
    //            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
    //            {
    //                if objSearchVM.totalPage ?? 0 >  objSearchVM.pageNumber && !objSearchVM.isSearching {
    //                    objSearchVM.pageNumber = objSearchVM.pageNumber + 1
    //                    fetchListOfUsers(shouldAnimate: true)
    //                }
    //
    //            }
    //        }
    //
    //
    //    }
    
}


