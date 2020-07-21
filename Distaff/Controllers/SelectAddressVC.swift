//
//  SelectAddressVC.swift
//  Distaff
//
//  Created by netset on 15/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class SelectAddressVC: BaseClass {
    
    var callBackSelctAddress : ((_ data:AddressData?)->())?
    var callBack_BackCase : ((_ totalCount:Int,_ doesSelectedAddressExit:Bool) -> ())?
    
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewSelectAddress: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    //MARK:VARIABLE(S)
    let objSelectAddressVM = SelectAdddressVM()
    var selectedId = -1   // for change Address
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    
}
//MARK:ALL METHOD(S)
extension SelectAddressVC {
    func prepareUI() {
        tblViewSelectAddress.removeExtraSeprators()
        handleTabbarVisibility(shouldHide: true)
        fetchAddressList()
    }
    
    func fetchAddressList() {
        objSelectAddressVM.callGetAddressListApi( shouldAnimate: true) {
            self.tblViewSelectAddress.reloadData()
            self.tblViewSelectAddress.showNoDataLabel(message: Messages.NoDataMessage.noAddressFound, arrayCount: self.objSelectAddressVM.addressListArray.count)
            let isDefaultAdrressExist = self.objSelectAddressVM.addressListArray.contains(where: {$0.default_address == true })
            if isDefaultAdrressExist {
                self.btnSubmit.isUserInteractionEnabled = true
                self.btnSubmit.alpha = 1.0
            }
            
            if self.selectedId != -1 && self.objSelectAddressVM.addressListArray.count > 0  {
                for i in 0..<self.objSelectAddressVM.addressListArray.count {
                    self.objSelectAddressVM.addressListArray[i].default_address = false
                }
                let index = self.objSelectAddressVM.addressListArray.firstIndex(where: {$0.id == self.selectedId })
                self.objSelectAddressVM.addressListArray[index ?? 0].default_address = true
                self.btnSubmit.isUserInteractionEnabled = true
                self.btnSubmit.alpha = 1.0
                self.tblViewSelectAddress.reloadData()
            }
            
        }
        
    }
    
}

//MARK:ALL ACTION(S)
extension SelectAddressVC {
    @IBAction func didTappedSubmit(_ sender: UIButton) {
        let index = self.objSelectAddressVM.addressListArray.firstIndex(where: { $0.default_address! == true })
        callBackSelctAddress?(self.objSelectAddressVM.addressListArray[index ?? 0])
        PopViewController()
    }
    
    @IBAction func didTappedAddnew(_ sender: UIButton) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.addNewAddressVC) as? AddNewAddressVC
        targetVC?.callBackAddAddress = { data in
            self.objSelectAddressVM.addressListArray.insert(data, at: 0)
            self.tblViewSelectAddress.reloadData()
            self.tblViewSelectAddress.showNoDataLabel(message: Messages.NoDataMessage.noAddressFound, arrayCount: self.objSelectAddressVM.addressListArray.count)
        }
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
        
    }
    @IBAction func didTappedBack(_ sender: UIButton) {
        PopViewController()
        
        let isDefaultAdrressExist = self.objSelectAddressVM.addressListArray.contains(where: {$0.id == selectedId })
        callBack_BackCase?(objSelectAddressVM.addressListArray.count, isDefaultAdrressExist)
    }
    
}
