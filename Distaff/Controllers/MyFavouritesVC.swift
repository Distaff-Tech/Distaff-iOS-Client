//
//  MyFavouritesVC.swift
//  Distaff
//
//  Created by netset on 17/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MyFavouritesVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewfavourites: UITableView!
    
    //MARK:VARIABLE(S)
    let objFavouriteVM = MyFavouritesVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func refreshData() {
        objFavouriteVM.callFavouriteListsApi(refreshControl: refreshControl, shouldAnimate: false) { (data) in
            self.tblViewfavourites.reloadData()
        }
    }
    
}

//MARK:ALL METHOD(S)
extension MyFavouritesVC {
    func prepareUI() {
        addRefreshControlInTable(tableView: self.tblViewfavourites)
        self.tblViewfavourites.setContentInsect(edgeInsets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        tblViewfavourites.estimatedRowHeight = 385.5
        objFavouriteVM.callFavouriteListsApi(refreshControl: refreshControl, shouldAnimate: true) { (data) in
            self.tblViewfavourites.showNoDataLabel(message:Messages.NoDataMessage.noFavouritePost, arrayCount: self.objFavouriteVM.postListArray.count)
            self.tblViewfavourites.reloadData()
        }
    }
}
//MARK:ALL ACTION(S
extension MyFavouritesVC {
    @IBAction func didTappedback(_ sender: UIButton) {
        Variables.shared.shouldLoadPostData = true
        PopViewController()
    }
    
}
