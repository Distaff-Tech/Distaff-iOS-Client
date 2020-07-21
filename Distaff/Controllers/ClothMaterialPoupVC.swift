//
//  ClothMaterialPoupVC.swift
//  Distaff
//
//  Created by netset on 11/02/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit

class ClothMaterialPoupVC: BaseClass {
    
    //MARK:OUTLET(S)
    @IBOutlet weak var tblViewClothMaterial: UITableView!
    
    //MARK:VARIABLE(S)
    var callBackFabricSelected : ((_ selectedFabric:[FabricModel]) -> ())?
    var clothMaterialList = [FabricModel]()
    
    
    //MARK:LIFE CYCLE(S)
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
    }
}

//MARK:TABLE DATA SOURCE DELEGATE(S)
extension ClothMaterialPoupVC :  UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothMaterialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewClothMaterial.dequeueReusableCell(withIdentifier: CellIdentifers.clothMaterialTableViewCell) as? ClothMaterialTableViewCell
        cell?.clothObject = clothMaterialList[indexPath.row]
        cell?.accessoryType = clothMaterialList[indexPath.row].isSelected == true ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clothMaterialList.mutateEach({($0.isSelected = false)})
        clothMaterialList[indexPath.row].isSelected = true
        tableView.reloadData()
    }
}
//MARK:ALL ACTION(S)
extension ClothMaterialPoupVC  {
    @IBAction func didTappedDone(_ sender: UIButton) {
        let isSelectedClothMaterial = clothMaterialList.contains(where: {$0.isSelected == true})
        if isSelectedClothMaterial {
            callBackFabricSelected?(clothMaterialList)
            dismissVC()
        }
        else {
            self.showAlert(message: Messages.Validation.chooseClothMaterial)
        }
    }
    
    @IBAction func didTappedCancel(_ sender: UIButton) {
        dismissVC()
    }
    
}
