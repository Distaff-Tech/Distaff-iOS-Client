//
//  MYCardsVM.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

class MYCardsVM {
    
    var cardListArray = [Cards]()
    
    func callGetCardsListApi(_completion:@escaping([Cards]? ) -> Void) {
        Services.getRequest(url: WebServicesApi.get_list_cards, shouldAnimateHudd: true) { (responseData) in
            do {
                let data = try JSONDecoder().decode(CardsListModel.self, from: responseData)
                self.cardListArray = data.cards ?? []
                _completion(data.cards ?? [])
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
        
    }
    
    
    
    func callDeleteCardApi(cardId:String,completion:@escaping() -> Void) {
        Services.postRequest(url: WebServicesApi.delete_card, param: [Delete_Card.card_id:cardId], shouldAnimateHudd: true) { (responseData) in
            do {
                let _ = try JSONDecoder().decode(SignInModel.self, from: responseData)
                completion()
            }
            catch {
                Alert.displayAlertOnWindow(with: error.localizedDescription)
            }
        }
    }
    
    
    
}

