//
//  HomeVM.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class HomeVM {
    
    var postListArray = [postListDetail]()
    
    var pageNumber = 1
    var doesNxtPageExist = false
    func callPostListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping(_ data:PostListModel?) -> Void) {
        let url = "\(WebServicesApi.get_homePage)page_num=\(pageNumber)"
        Services.getRequest(url: url, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(PostListModel.self, from: responseData)
                self.doesNxtPageExist = data.has_next ?? false
                self.postListArray = self.pageNumber == 1 ? data.data ?? [] :  self.postListArray + (data.data ?? [])
                _completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
}


