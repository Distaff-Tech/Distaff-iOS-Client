//
//  SelectPaymentVC.swift
//  Distaff
//
//  Created by netset on 22/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SelectPaymentVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewSelectPayment: UITableView!
    @IBOutlet weak var btnMakePayment: UIButton!
    @IBOutlet weak var lblSavedCards: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet var lblServiceCharge: UILabel!
    @IBOutlet var lblServiceNameTitle: UILabel!
    
    //MARK:VARIABLE(S)
    var subTotalPriceDouble:Double?
    var serviceCharge:Double?
    var addressId:Int?
    let objSelectPaymentVM = SelectPaymentVM()
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
}

//MARK:ALL METHOD(S)
extension SelectPaymentVC {
    func prepareUI() {
        handleTabbarVisibility(shouldHide: true)
        getCardListAdded()
        let servicePrice = (((subTotalPriceDouble ?? 0.0) * (serviceCharge ?? 0.0) ) / 100).truncate(places: 2)
        let totalPrice = (subTotalPriceDouble ?? 0.0) + servicePrice
        lblTotal.text = "$\(totalPrice.calculateCurrency(fractionDigits: 2) )"
        lblSubTotal.text = "$\(subTotalPriceDouble?.calculateCurrency(fractionDigits: 2) ?? "")"
        lblServiceCharge.text = "$\(servicePrice.calculateCurrency(fractionDigits: 2) )"
        lblServiceNameTitle.text = "\("Service Charge") \( "(\((serviceCharge?.calculateCurrency(fractionDigits: 2)) ?? "1")%)")"
    }
    
    func getCardListAdded() {
        let object = MYCardsVM()
        object.callGetCardsListApi { (data) in
            self.objSelectPaymentVM.cardListArray = data ?? []
            self.tblViewSelectPayment.reloadData()
            self.lblSavedCards.text = self.objSelectPaymentVM.cardListArray.count == 0 ? "NO SAVED CARDS" : "SAVED CARDS"
            
        }
        
    }
    
}
//MARK:ALL ACTION(S)
extension SelectPaymentVC {
    @IBAction func didPressBack(_ sender: UIButton) {
        PopViewController()
    }
    
    @IBAction func didTappedMakePayment(_ sender: UIButton) {
        let cardId = objSelectPaymentVM.cardListArray[objSelectPaymentVM.selectedIndex].id ?? ""
        let totalPrice = String((lblTotal.text ?? "$0.0").dropFirst())
        objSelectPaymentVM.callMakePaymentApi(MakePayment.Request(amount:totalPrice.toDouble(), cardId: cardId,addressId:addressId)) {
            userdefaultsRef.set(0, forKey: UserDefaultsKeys.cartCount)
            self.presentViewController(withIdentifer: ViewControllersIdentifers.orderSuccessPopupVC)
        }
        
    }
    
    @IBAction func didTappedAddnewcard(_ sender: UIButton) {
        let targetVC = loginStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.paymentVC) as? SetPaymentVC
        targetVC?.isFromPostFlow = true
        targetVC?.callBackCardAdded = { newCardData in
            self.objSelectPaymentVM.cardListArray.append(newCardData!)
            self.tblViewSelectPayment.reloadData()
            self.lblSavedCards.text = self.objSelectPaymentVM.cardListArray.count == 0 ? "NO SAVED CARDS" : "SAVED CARDS"
        }
        
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        
    }
    
}
