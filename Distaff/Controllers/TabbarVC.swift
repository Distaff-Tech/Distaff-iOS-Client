//
//  TabbarVC.swift
//  Distaff
//
//  Created by netset on 20/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}
extension TabbarVC : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //        Variables.shared.shouldLoadProfileData = true
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePostPopupVC") as? CreatePostPopupVC
            targetVC?.modalPresentationStyle = .overCurrentContext
            self.present(targetVC ?? UIViewController(), animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
}

