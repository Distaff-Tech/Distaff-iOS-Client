//
//  SelectPaymentDataSource.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension SelectPaymentVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objSelectPaymentVM.cardListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.selectPaymentTableCell) as? SelectPaymentTableCell
        cell?.cardObject = objSelectPaymentVM.cardListArray[indexPath.row]
        cell?.radioBtn.isSelected =  objSelectPaymentVM.selectedIndex == indexPath.row ? true : false
        cell?.callBackRadioBtn = {
            self.objSelectPaymentVM.selectedIndex = indexPath.row
            self.btnMakePayment.isUserInteractionEnabled = true
            self.btnMakePayment.alpha = 1.0
            tableView.reloadData()
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

