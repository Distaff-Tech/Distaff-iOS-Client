//
//  WebVCDataSource.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import WebKit

//MARK:- WEB VIEW DELEGATE(S)
extension WebVC : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        ActivityIndicatorManager.sharedInstance.stopAnimating()
        print(error.localizedDescription)
        self.showAlert(message: error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicatorManager.sharedInstance.stopAnimating()
        debugPrint("finish to load")
    }
}

