    //
    //  ShoppingBagVC.swift
    //  Distaff
    //
    //  Created by netset on 21/01/20.
    //  Copyright © 2020 netset. All rights reserved.
    //
    
    import UIKit
    
    class ShoppingBagVC: BaseClass {
        
        //MARK:OUTLET(S)
        @IBOutlet weak var stackViewChooseAddress: UIStackView!
        @IBOutlet weak var stackViewCheckout: UIStackView!
        @IBOutlet weak var tblViewShoppingBag: UITableView!
        @IBOutlet weak var btnContinue: UIButton!
        
        
        //MARK:VARIABLE(S)
        let objShoppingBagVM = ShoppingBagVM()
        
        
        //MARK:LIFE CYCLE(S)
        override func viewDidLoad() {
            super.viewDidLoad()
            prepareUI()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
        }
        
    }
    
    //MARK:ALL ACTION(S)
    extension ShoppingBagVC {
        @IBAction func didTappedChangeAddress(_ sender: UIButton) {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.selectAddressVC) as? SelectAddressVC
            targetVC?.callBackSelctAddress = { data in
                self.objShoppingBagVM.isAddressChoosen = true
                self.self.stackViewChooseAddress.isHidden = self.objShoppingBagVM.isAddressChoosen ? true : false
                self.objShoppingBagVM.addressObject = data
                self.stackViewCheckout.isHidden = self.objShoppingBagVM.isAddressChoosen ? false : true
                self.tblViewShoppingBag.reloadData()
            }
            
            targetVC?.callBack_BackCase = { totalAddressCount,isDefaultAddressExit in
                if totalAddressCount == 0 || !isDefaultAddressExit  {
                    self.objShoppingBagVM.isAddressChoosen = false
                    self.tblViewShoppingBag.reloadData()
                    self.btnContinue.alpha = self.objShoppingBagVM.isAddressChoosen ? 1.0 : 0.4
                    self.btnContinue.isUserInteractionEnabled = self.objShoppingBagVM.isAddressChoosen ? true : false
                    self.stackViewChooseAddress.isHidden = false
                    self.stackViewCheckout.isHidden = true
                }
                
            }
            
            
            targetVC?.selectedId = objShoppingBagVM.addressObject?.id ?? 0
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        
        @IBAction func didTappedContinue(_ sender: UIButton) {
            let targetVc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.selectPaymentVC) as? SelectPaymentVC
            targetVc?.subTotalPriceDouble = calculateSubTotalPrice().1
            targetVc?.serviceCharge = objShoppingBagVM.serviceCharge ?? 0.0
            targetVc?.addressId = objShoppingBagVM.addressObject?.id ?? 0
            self.navigationController?.pushViewController(targetVc ?? UIViewController(), animated: true)
        }
        
        @IBAction func didTappedSelectAddress(_ sender: UIButton) {
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.selectAddressVC) as? SelectAddressVC
            targetVC?.callBackSelctAddress = { data in
                self.objShoppingBagVM.addressObject = data
                self.objShoppingBagVM.isAddressChoosen = true
                self.stackViewChooseAddress.isHidden = self.objShoppingBagVM.isAddressChoosen ? true : false
                self.stackViewCheckout.isHidden = self.objShoppingBagVM.isAddressChoosen ? false : true
                self.tblViewShoppingBag.reloadData()
            }
            
            targetVC?.callBack_BackCase = { totalAddressCount,isDefaultAddressExit in
                if totalAddressCount == 0 {
                    self.objShoppingBagVM.isAddressChoosen = false
                    self.tblViewShoppingBag.reloadData()
                    self.btnContinue.alpha = self.objShoppingBagVM.isAddressChoosen ? 1.0 : 0.4
                    self.btnContinue.isUserInteractionEnabled = self.objShoppingBagVM.isAddressChoosen ? true : false
                    self.stackViewChooseAddress.isHidden = false
                    self.stackViewCheckout.isHidden = true
                    
                }
            }
            
            self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        }
        
        @IBAction func didTappedCheckout(_ sender: UIButton) {
            let targetVc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.selectPaymentVC) as? SelectPaymentVC
            targetVc?.subTotalPriceDouble = calculateSubTotalPrice().1
           targetVc?.serviceCharge = objShoppingBagVM.serviceCharge ?? 0.0
            targetVc?.addressId = objShoppingBagVM.addressObject?.id ?? 0
            self.navigationController?.pushViewController(targetVc ?? UIViewController(), animated: true)
            
        }
        
        
        @IBAction func didTappedBAck(_ sender: UIButton) {
            PopViewController()
        }
        
    }
    //MARK:ALL METHOD(S)
    extension ShoppingBagVC {
        func prepareUI() {
            handleTabbarVisibility(shouldHide: true)
            tblViewShoppingBag.removeExtraSeprators()
            stackViewChooseAddress.isHidden = objShoppingBagVM.isAddressChoosen  ? true : false
            stackViewCheckout.isHidden = objShoppingBagVM.isAddressChoosen ? false : true
            getShoppingBagList()
            
        }
        
        
        func getShoppingBagList() {
            objShoppingBagVM.callGetShoppingBagListApi( shouldAnimate: true) {
                self.tblViewShoppingBag.dataSource = self
                self.tblViewShoppingBag.delegate = self
                self.tblViewShoppingBag.reloadData()
                self.tblViewShoppingBag.showNoDataLabel(message: Messages.NoDataMessage.cartListEmpty, arrayCount: self.objShoppingBagVM.shoppingBagItems.count)
                self.handleNoItemsUI()
                self.btnContinue.alpha = self.objShoppingBagVM.isAddressChoosen ? 1.0 : 0.4
                self.btnContinue.isUserInteractionEnabled = self.objShoppingBagVM.isAddressChoosen ? true : false
                
            }
            
        }
        
        func calculateSubTotalPrice() -> (String,Double) {
            var price  = 0.0
            for i in 0..<objShoppingBagVM.shoppingBagItems.count {
                let doublePrice = Double((objShoppingBagVM.shoppingBagItems[i].price ?? "0.00"))
                price = price + (doublePrice ?? 0.00)
            }
            return (price.calculateCurrency(fractionDigits: 2),price)
        }
        
        func calculateTotalPrice()  -> (String,String) {
            let subTotalPrice = calculateSubTotalPrice().1
            let servicePrice = ((subTotalPrice * (objShoppingBagVM.serviceCharge ?? 0.0) ) / 100).truncate(places: 2)
            let totalPrice = subTotalPrice + servicePrice
            return (totalPrice.calculateCurrency(fractionDigits: 2),servicePrice.calculateCurrency(fractionDigits: 2))
        }
        
        func handleNoItemsUI() {
            if self.objShoppingBagVM.shoppingBagItems.count == 0 {
                self.stackViewChooseAddress.isHidden = true
                self.stackViewCheckout.isHidden = true
                self.tblViewShoppingBag.removeExtraSeprators()
                self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        
    }
