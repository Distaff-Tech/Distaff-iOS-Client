//
//  SettingsDataSource.swift
//  Distaff
//
//  Created by netset on 13/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension SettingsVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objSettingsVM.settingsListingArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tblViewSettings.dequeueReusableCell(withIdentifier:CellIdentifers.settingsTableNotificationCell) as? SettingsTableNoticationCell
            cell?.callbackValueChanged =  { isSwitchOn in
                self.objSettingsVM.callNotificationToggleApi(isSwitchOn == true ? 1 : 0) { (data) in
                    var userObject = (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))
                    userObject?.notificationStatus = isSwitchOn == true ? 1 : 0
                    userdefaultsRef.set(encodable: userObject, forKey: UserDefaultsKeys.userInfo)
                    
                }
            }
            
            cell?.notificationSwitch.isOn =  (userdefaultsRef.value(Response.self, forKey: UserDefaultsKeys.userInfo))?.notificationStatus ?? 0 == 1 ? true : false
            
            
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tblViewSettings.dequeueReusableCell(withIdentifier:CellIdentifers.settingsTableOtherCell) as? SettingsTableOtherCell
            cell?.settingsObject = objSettingsVM.settingsListingArray[indexPath.row - 1]
            let imageView: UIImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = UIImage(named: "forwardArrow")
            imageView.contentMode = .scaleAspectFit
            cell?.accessoryView = imageView
            return cell ?? UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            switchToPages(with: objSettingsVM.settingsListingArray[indexPath.row - 1].title ?? "")
        }
    }
    
    
    func switchToPages(with title:String) {
        
        switch title {
        case "My Favorites":
            pushToViewController(VC: ViewControllersIdentifers.myFavouriteVC)
        case "My Cards":
            pushToViewController(VC: ViewControllersIdentifers.myCardsVC)
        case "Change Password":
            pushToViewController(VC: ViewControllersIdentifers.changePasswordVC)
            
            case "Manage Bank":
                     
                 let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.addBankVC) as! AddBankVC
                 self.navigationController?.pushViewController(targetVC, animated: true)

            
            
        case "Terms and Conditions":
            let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.webVC) as! WebVC
             targetVC.webViewData = WebView(title: "Terms and Conditions", url: WebUrlLinks.termsOfUse)
            self.navigationController?.pushViewController(targetVC, animated: true)
            
        case "Privacy Policies":
            let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.webVC) as! WebVC
            targetVC.webViewData = WebView(title: "Privacy Policies", url: WebUrlLinks.privacyPolicy)
            self.navigationController?.pushViewController(targetVC, animated: true)
        case "Help and Support":
            pushToViewController(VC: ViewControllersIdentifers.helpAndSupportVC)
        case "Logout":
            logoutUser()
            print(index)
            
        default:
            print("default")
        }
        
    }
    
    fileprivate func logoutUser() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:"Are you sure you want to Logout?", message: nil, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Logout", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.objSettingsVM.callLogoutApi { (data) in
                    CommonMethods.setRoot(VC: loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.initialNavigation))
                }
                
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
            {
                (alert: UIAlertAction!) -> Void in
                
            })
            alert.view.tintColor = AppColors.appColorBlue
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
