//
//  SearchPostVM.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class SearchUsersVM {
    
    var pageNumber = 1
    var totalPage:Int?
    var didUserSearched = false
    
    var serachUsersArray = [SearchUsersData]()
    
    //MARK: Get User List Api
    func callSearchUser(shouldAnimate:Bool,refreshControl:UIRefreshControl? = nil, searchText:String,_completion:@escaping() -> Void) {
        let url = "\(WebServicesApi.search_user)page_num=\(pageNumber)"
        Services.postRequest(url: url, param: [Search_Users.searchText:searchText ], shouldAnimateHudd: shouldAnimate ,refreshControl : refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(SearchUsersModel.self, from: responseData)
                self.serachUsersArray = self.pageNumber == 1 ? data.data ?? [] :  self.serachUsersArray + (data.data ?? [])
                self.totalPage = data.total_pages ?? 0
                _completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
}
