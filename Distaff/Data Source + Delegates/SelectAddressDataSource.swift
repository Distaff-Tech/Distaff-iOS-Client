//
//  SelectAddressDataSource.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension SelectAddressVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objSelectAddressVM.addressListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.selectAddressTableViewCell) as? SelectAddressTableViewCell
        cell?.addressObj = objSelectAddressVM.addressListArray[indexPath.row]
        
        cell?.callBackSelectAddress = {
            for i in 0..<self.objSelectAddressVM.addressListArray.count {
                self.objSelectAddressVM.addressListArray[i].default_address = false
            }
            self.objSelectAddressVM.addressListArray[indexPath.row].default_address = true
            self.btnSubmit.isUserInteractionEnabled = true
            self.btnSubmit.alpha = 1.0
            tableView.reloadData()
        }
        
        cell?.callBackDeleteAddress = {
            self.showAlertWithActionAndCancel(message:Messages.DialogMessages.deleteAddress) {
                self.objSelectAddressVM.callDeleteAddressApi(addressId: self.objSelectAddressVM.addressListArray[indexPath.row].id ?? 0) {
                    let isSelected = self.objSelectAddressVM.addressListArray[indexPath.row].default_address
                    self.objSelectAddressVM.addressListArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    self.tblViewSelectAddress.showNoDataLabel(message: Messages.NoDataMessage.noAddressFound, arrayCount: self.objSelectAddressVM.addressListArray.count)
                    if self.objSelectAddressVM.addressListArray.count == 0 || isSelected == true {
                        self.btnSubmit.isUserInteractionEnabled = false
                        self.btnSubmit.alpha = 0.4
                    }
                }
            }
        }
        
        return cell ?? UITableViewCell()
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


