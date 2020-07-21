//
//  MYCardsVC.swift
//  Distaff
//
//  Created by netset on 14/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class MYCardsVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewMyCards: UITableView!
    @IBOutlet weak var lblSavedCards: UILabel!
    
    //MARK:VARIABLE(S)
    let objMyCardsVM = MYCardsVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
}

//MARK:ALL METHODS(S)
extension MYCardsVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        objMyCardsVM.callGetCardsListApi { (data) in
            self.tblViewMyCards.reloadData()
            self.lblSavedCards.text = self.objMyCardsVM.cardListArray.count == 0 ? Messages.NoDataMessage.noSavedCard : Messages.NoDataMessage.savedCard
        }
        
    }
}

//MARK:ALL ACTION(S)
extension MYCardsVC {
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedAddNewCard(_ sender: UIButton) {
        let targetVC = loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.paymentVC) as? SetPaymentVC
        targetVC?.isFromPostFlow = true
        targetVC?.callBackCardAdded = { newCardData in
            self.objMyCardsVM.cardListArray.append(newCardData!)
            self.tblViewMyCards.reloadData()
            self.lblSavedCards.text = self.objMyCardsVM.cardListArray.count == 0 ? Messages.NoDataMessage.noSavedCard : Messages.NoDataMessage.savedCard
        }
        
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        
    }
    
}
