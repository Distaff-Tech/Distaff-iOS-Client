//
//  SearchUserVC.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SearchUserVC: BaseClass {
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewSearch: UITableView!
    
    //MARK:VARIABLE(S)
    let objSearchVM = SearchUsersVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        disableIQKeyboard()
        handleTabbarVisibility(shouldHide: false)
        removeRefreshControl()
    }
    
    override func refreshData() {
        objSearchVM.pageNumber = 1
        fetchListOfUsers(shouldAnimate: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        enableIQKeyboard()
    }
    
}



//MARK:ALL METHOD(S)
extension SearchUserVC {
    func prepareUI() {
        self.tblViewSearch.estimatedRowHeight = 80.5
        self.tblViewSearch.rowHeight = UITableView.automaticDimension
        self.tblViewSearch.setContentInsect(edgeInsets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        addSerachBarInNavigation(placeholderText: "Search users by user name", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), textFont: UIFont(name: AppFont.fontRegular, size: 16.0)!)
        tblViewSearch.removeExtraSeprators()
        addRefreshControlInTable(tableView: self.tblViewSearch)
        fetchListOfUsers(shouldAnimate: true)
    }
    
    
    func fetchListOfUsers(shouldAnimate:Bool) {
        objSearchVM.callSearchUser(shouldAnimate: shouldAnimate,refreshControl:shouldAnimate == false ? refreshControl : nil,searchText: searchBarController.text ?? "") {
            self.tblViewSearch.showNoDataLabel(message: Messages.NoDataMessage.noUserFound, arrayCount: self.objSearchVM.serachUsersArray.count)
            self.tblViewSearch.reloadData()
        }
    }
    

    
    override func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    
        searchBarController.setShowsCancelButton(true, animated: true)
    }
    
    

 
    
    
    override func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarController.text = ""
        searchBarController.endEditing(true)
        if objSearchVM.didUserSearched {
        objSearchVM.pageNumber = 1
        if self.objSearchVM.serachUsersArray.count > 0 {
            self.tblViewSearch.scrollToTop(indexPath: NSIndexPath(item: 0, section: 0))
            
        }
        fetchListOfUsers(shouldAnimate: true)
        }
         objSearchVM.didUserSearched = false
    }
    
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        objSearchVM.didUserSearched = true
        objSearchVM.pageNumber = 1
        fetchListOfUsers(shouldAnimate: true)
    }
    
}
