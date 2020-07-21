//
//  TermsConditionVC.swift
//  Distaff
//
//  Created by netset on 10/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import WebKit
class TermsConditionVC: BaseClass {
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnCheckMark: UIButton!
    
    //MARK:OVERRIDE METHODS(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
}


//MARK:ALL METHODS(S)
extension TermsConditionVC {
    func prepareUI() {
        webView.navigationDelegate = self
        webView.loadUrlRequest(WebUrlLinks.termsOfUse)
        ActivityIndicatorManager.sharedInstance.startAnimating()
    }
}

//MARK:ALL ACTION(S)
extension TermsConditionVC {
    @IBAction func didTappedCancel(_ sender: UIButton) {
        dismissVC()
    }
    
    
    @IBAction func didTappedAgree(_ sender: UIButton) {
        userdefaultsRef.set(true, forKey: UserDefaultsKeys.hasAcceptedTermsCondition)
        dismissAndPushToViewController(identifer: ViewControllersIdentifers.createProfileVC)
    }
    
    @IBAction func didTappedCheckMark(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnAgree.isUserInteractionEnabled = sender.isSelected ? true : false
        btnAgree.alpha = sender.isSelected ? 1.0 : 0.4
    }
}

