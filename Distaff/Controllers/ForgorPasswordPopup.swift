//
//  ForgorPasswordPopup.swift
//  Distaff
//
//  Created by netset on 09/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ForgorPasswordPopup: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var lblTitle: UILabel!
    
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
}
//MARK:ALL METHODS(S)
extension ForgorPasswordPopup {
    func prepareUI() {
        self.lblTitle.addInterlineSpacing(spacingValue: 6, text:Messages.TextMessages.passwordResetEmail)
    }
}
//MARK:ALL ACTION(S)
extension ForgorPasswordPopup {
    @IBAction func didTappedOK(_ sender: UIButton) {
        dismissAndPopToRoot()
    }
}

