//
//  OrderSuccessPopupVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class OrderSuccessPopupVC: BaseClass {
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
//MARK:ALL ACTION(S)
extension OrderSuccessPopupVC {
    @IBAction func didTappedHistory(_ sender: UIButton) {
        dismissPopToRootAndChangeTabbar()
    }
    @IBAction func didTappedContinue(_ sender: UIButton) {
        dismissAndPopToRoot()
        
    }
}
