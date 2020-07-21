//
//  ShoppingBagDataSource.swift
//  Distaff
//
//  Created by netset on 21/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser

//MARK:TABLE DATA SOURCE(S)
extension ShoppingBagVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objShoppingBagVM.shoppingBagItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == objShoppingBagVM.shoppingBagItems.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.shoppingFooterTableViewCell) as?  ShoppingFooterTableViewCell
            cell?.shoppingAddressView.isHidden = objShoppingBagVM.isAddressChoosen ? false : true
            cell?.lblSubTotal.text = "$\(calculateSubTotalPrice().0)"
            cell?.lblTotal.text = "$\(calculateTotalPrice().0)"
            cell?.lblServiceCharge.text = "$\(calculateTotalPrice().1)"
            cell?.lblServiceChargeTitle.text = "\("Service Charge") \( "(\((objShoppingBagVM.serviceCharge?.calculateCurrency(fractionDigits: 2)) ?? "1")%)")"
            cell?.lblName.text =  "\(objShoppingBagVM.addressObject?.first_name ?? "")\(" ") \( objShoppingBagVM.addressObject?.last_name ?? "")"
            cell?.lblAddress.text = objShoppingBagVM.addressObject?.address
            cell?.lblAddress.text = "\(objShoppingBagVM.addressObject?.address ?? "")\(", \(objShoppingBagVM.addressObject?.city ?? "")")\(", \(objShoppingBagVM.addressObject?.postal_code ?? "")")"
            cell?.lblPhoneNo.text = objShoppingBagVM.addressObject?.phone ?? ""
            return cell ?? UITableViewCell()
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.shoppingBagTableViewCell) as? ShoppingBagTableViewCell
            cell?.callBackDeleteItem = {
                self.showAlertWithActionAndCancel(message:Messages.DialogMessages.deleteItem) {
                    self.objShoppingBagVM.callDeleteItemFromCart(cartId: self.objShoppingBagVM.shoppingBagItems[indexPath.row].id ?? 0) {
                        self.objShoppingBagVM.shoppingBagItems.remove(at: indexPath.row)
                        tableView.reloadData()
                        self.tblViewShoppingBag.showNoDataLabel(message: Messages.NoDataMessage.cartListEmpty, arrayCount: self.objShoppingBagVM.shoppingBagItems.count)
                        self.handleNoItemsUI()
                        let totalCount = userdefaultsRef.value(forKey: UserDefaultsKeys.cartCount) as? Int
                        userdefaultsRef.set((totalCount ?? 1) - 1, forKey: UserDefaultsKeys.cartCount)
                    }
                }
                
            }
            
            cell?.callBackPostImageTapped = {
                var images = [SKPhotoProtocol]()
                let photo = SKPhoto.photoWithImageURL("\(WebServicesApi.imageBaseUrl)\(self.objShoppingBagVM.shoppingBagItems[indexPath.row].post_image ?? "")")
                photo.shouldCachePhotoURLImage = true
                images.append(photo)
                self.displayZoomImages(imageArray: images, index: 0)
            }
            
            cell?.object = objShoppingBagVM.shoppingBagItems[indexPath.item]
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == objShoppingBagVM.shoppingBagItems.count  {
            return objShoppingBagVM.shoppingBagItems.count == 0 ? 0 : objShoppingBagVM.isAddressChoosen ? 364 : 200
        }
            
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

