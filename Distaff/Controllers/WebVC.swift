//
//  WebVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import WebKit
class WebVC: BaseClass {
    
    @IBOutlet weak var webView: WKWebView!
    var webViewData:WebView?
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
        
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
}


//MARK:ALL METHODS(S)
extension WebVC {
    func prepareUI() {
        webView.navigationDelegate = self
        self.title = webViewData?.title?.uppercased()
        webView.loadUrlRequest(webViewData?.url ?? "")
        ActivityIndicatorManager.sharedInstance.startAnimating()
        handleTabbarVisibility(shouldHide: true)
    }
}
