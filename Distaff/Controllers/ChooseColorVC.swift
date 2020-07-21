//
//  ChooseColorVC.swift
//  Distaff
//
//  Created by netset on 13/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ChooseColorVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var collectionViewChooseColor: UICollectionView!
    @IBOutlet weak var tblViewChooseColor: UITableView!
    
    
    //MARK:VARIABLE(S)
    var callBackSelectedColor : ((_ colorId:Int?)->())?
    var selectedIndex = -1
    var isFromAddPostPage = false
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

//MARK:- All ACTION(S)
extension ChooseColorVC {
    
    @IBAction func didTappedCancel(_ sender: UIButton) {
        dismissVC()
    }
    
    @IBAction func didTappedDone(_ sender: UIButton) {
        if selectedIndex == -1 {
            self.showAlert(message: "Please choose color first")
        }
        else {
            callBackSelectedColor?(Variables.shared.colorListArray[selectedIndex].id ?? 0)
            dismissVC()
        }
    }
    
}
