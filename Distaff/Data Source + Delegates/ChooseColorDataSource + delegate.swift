//
//  ChooseColorDataSource + delegate.swift
//  Distaff
//
//  Created by netset on 13/02/20.
//  Copyright © 2020 netset. All rights reserved.
//



import Foundation
import UIKit

//MARK:TABLE DATA SOURCE(S)
extension ChooseColorVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Variables.shared.colorListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifers.clothMaterialTableViewCell) as? ClothMaterialTableViewCell
        
        cell?.accessoryType  = selectedIndex == indexPath.row ? .checkmark: .none
        
        cell?.lblTitle.text = Variables.shared.colorListArray[indexPath.row].colour ?? ""
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    
}
