//
//  MyCardsDataSource.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE DELEGATE(S)
extension MYCardsVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objMyCardsVM.cardListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.myCardsTableViewCell) as? MyCardsTableViewCell
        cell?.cardsObject = objMyCardsVM.cardListArray[indexPath.row]
        cell?.callBackDeleteCard = {
            self.showAlertWithActionAndCancel(message:Messages.DialogMessages.deleteCard) {
                self.objMyCardsVM.callDeleteCardApi(cardId: self.objMyCardsVM.cardListArray[indexPath.row].id ?? "") {
                    self.objMyCardsVM.cardListArray.remove(at: indexPath.row)
                    tableView.reloadData()
                      self.lblSavedCards.text = self.objMyCardsVM.cardListArray.count == 0 ? Messages.NoDataMessage.noSavedCard : Messages.NoDataMessage.savedCard
                }
            }
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
