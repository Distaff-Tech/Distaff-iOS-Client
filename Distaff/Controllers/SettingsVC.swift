//
//  SettingsVC.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SettingsVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewSettings: UITableView!
    
    //MARK:VARIABLE(S)
    var objSettingsVM = SettingsVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    
}

//MARK:ALL METHODS(S)
extension SettingsVC {
    func prepareUI() {
        showNavigationBar()
        handleTabbarVisibility(shouldHide: true)
        tblViewSettings.removeExtraSeprators()
        removePasswordForSocialUser()
    }
    
    func removePasswordForSocialUser() {
        if (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.login_type != "e" {
            objSettingsVM.settingsListingArray.remove(at: 2)
            tblViewSettings.reloadData()
        }
        
    }
    
    
    
}

//MARK:ALL ACTION(S)
extension SettingsVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
        handleTabbarVisibility(shouldHide: false)
    }
    
}
