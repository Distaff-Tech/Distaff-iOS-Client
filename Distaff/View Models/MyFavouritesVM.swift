//
//  MyFavouritesVM.swift
//  Distaff
//
//  Created by netset on 26/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class MyFavouritesVM {
    
    var postListArray = [postListDetail]()
    
    var pageNumber = 1
    var doesNxtPageExist = false
    
    
    func callFavouriteListsApi(refreshControl:UIRefreshControl? = nil,shouldAnimate:Bool,_completion:@escaping(_ data:PostListModel?) -> Void) {
        let url = "\(WebServicesApi.get_favourite)page_num=\(pageNumber)"
        Services.getRequest(url: url, shouldAnimateHudd: shouldAnimate, refreshControl: refreshControl) { (responseData) in
            do {
                let data = try JSONDecoder().decode(PostListModel.self, from: responseData)
                self.doesNxtPageExist = data.has_next ?? false
                //                self.postListArray = self.pageNumber == 1 ? data.data ?? [] :  self.postListArray + (data.data ?? [])
                self.postListArray =  data.data ?? []
                _completion(data)
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
}
