//
//  MyOrderDataSource + Delegate.swift
//  Distaff
//
//  Created by netset on 19/03/20.
//  Copyright © 2020 netset. All rights reserved.
//

import Foundation
import UIKit

//MARK:TABLE DATA SOURCE DELEGATE(S)
extension OrderHistoryVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  btnMyRequest.alpha == 1.0 ? objMyOrderVM.myRequestArray[section]?.list?.count ?? 0 : objMyOrderVM.myOrdersArray[section]?.list?.count ?? 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return btnMyRequest.alpha == 1.0 ? objMyOrderVM.myRequestArray.count : objMyOrderVM.myOrdersArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView  = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        headerView.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 100, height: 20))
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: AppFont.fontRegular, size: 14.0)
        titleLabel.text = CommonMethods.convertDateFormat(inputFormat: "yyyy-MM-dd", outputFormat: "MMM dd, yyyy", dateString: btnMyRequest.alpha == 1.0 ? objMyOrderVM.myRequestArray[section]?.date ?? "" : objMyOrderVM.myOrdersArray[section]?.date ?? "" )
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  btnMyRequest.alpha == 1.0 ? ((objMyOrderVM.myRequestArray[section]?.list?.count ?? 0) > 0 ? 40.0 : 0.0 ) : objMyOrderVM.myOrdersArray[section]?.list?.count ?? 0 > 0 ? 40.0 : 0.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if btnMyRequest.alpha == 1.0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.myRequestTableViewCell) as? MyRequestTableViewCell
            cell?.orderObject = objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row]
            cell?.callBackAccepted = {
                CommonMethods.callAcceptRejectOrderApi(order_id: self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].id ?? 0, order_status: true) {
                    self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].order_status = 1
                    tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            cell?.callBackDeclined = {
                CommonMethods.callAcceptRejectOrderApi(order_id: self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].id ?? 0, order_status: false) {
                    self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].order_status = 2
                    tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            return cell ?? UITableViewCell()
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:CellIdentifers.pastOrdersTableViewCell) as? PastOrdersTableViewCell
            cell?.orderObject = objMyOrderVM.myOrdersArray[indexPath.section]?.list?[indexPath.row]
            return cell ?? UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderDetailVC) as? OrderDetailVC
        targetVC?.isMyOrder =  btnMyRequest.alpha == 1.0 ? false
            : true
        targetVC?.orderId = btnMyRequest.alpha == 1.0 ? objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].id  ?? 0 : objMyOrderVM.myOrdersArray[indexPath.section]?.list?[indexPath.row].id  ?? 0
        
        targetVC?.callBackAccepted = {
            self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].order_status = 1
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        targetVC?.callBackDeclined = {
            self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].order_status = 2
            tableView.reloadRows(at: [indexPath], with: .none)
            
        }
        
        targetVC?.callBackCancelled = {
            self.objMyOrderVM.myOrdersArray[indexPath.section]?.list?[indexPath.row].order_status = -2
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        self.navigationController?.pushViewController(targetVC ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .normal, title:nil, handler: { (action,view,completionHandler ) in
            
            let isMyRequest = self.btnMyRequest.alpha == 1.0 ? true : false
            self.showAlertWithCancelAndOkAction(message: Messages.DialogMessages.deleteOrder, onComplete: {
                self.objMyOrderVM.callDeleteOrderApi(orderId: isMyRequest == true ? self.objMyOrderVM.myRequestArray[indexPath.section]?.list?[indexPath.row].id : self.objMyOrderVM.myOrdersArray[indexPath.section]?.list?[indexPath.row].id) {
                    
                    if !isMyRequest {
                        if self.objMyOrderVM.myOrdersArray[indexPath.section]?.list?.count == 1 {
                            self.objMyOrderVM.myOrdersArray.remove(at: indexPath.section)
                            tableView.reloadData()
                        }
                        else {
                            self.objMyOrderVM.myOrdersArray[indexPath.section]?.list?.remove(at: indexPath.row)
                            UIView.setAnimationsEnabled(false)
                            tableView.beginUpdates()
                            //   let indexPath = NSIndexPath(row: indexPath.row, section: indexPath.section)
                            //                            DispatchQueue.main.async {
                            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .none)
                            //                                let indexSet = NSIndexSet(index: indexPath.section)
                            //                                tableView.reloadSections(indexSet as IndexSet, with: .none)
                            tableView.endUpdates()
                            UIView.setAnimationsEnabled(true)
                            //                            }
                        }
                        
                        self.tblViewOrders.showNoDataLabel(message: Messages.NoDataMessage.noMyOrder, arrayCount: self.objMyOrderVM.myOrdersArray.count)
                    }
                    else {
                        
                        if self.objMyOrderVM.myRequestArray[indexPath.section]?.list?.count == 1 {
                            self.objMyOrderVM.myRequestArray.remove(at: indexPath.section)
                            tableView.reloadData()
                        }
                            
                        else {
                            
                            self.objMyOrderVM.myRequestArray[indexPath.section]?.list?.remove(at: indexPath.row)
                            UIView.setAnimationsEnabled(false)
                            tableView.beginUpdates()
                            //                            let indexPath = NSIndexPath(row: indexPath.row, section: indexPath.section)
                            //                            DispatchQueue.main.async {
                            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .none)
                            //                                let indexSet = NSIndexSet(index: indexPath.section)
                            //                                tableView.reloadSections(indexSet as IndexSet, with: .none)
                            tableView.endUpdates()
                            UIView.setAnimationsEnabled(true)
                            
                            //                            }
                        }
                        
                        self.tblViewOrders.showNoDataLabel(message: Messages.NoDataMessage.noMyRequest, arrayCount: self.objMyOrderVM.myRequestArray.count)
                    }
                    
                }
                
            }) {
                self.tblViewOrders.isEditing = false
            }
            
            
        })
        action.image = UIImage(named: "delete")
        action.backgroundColor = AppColors.appColorBlue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
        
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tblViewOrders && !refreshControl.isRefreshing {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if btnMyRequest.alpha == 1.0 {
                    
                    if objMyOrderVM.doesNxtPageExistMyRequest {
                        objMyOrderVM.myRequestPageNumber = objMyOrderVM.myRequestPageNumber + 1
                        getMyRequestList(shouldAnimate: true)
                    }
                }
                else {
                    if objMyOrderVM.doesNxtPageExistMyOrders {
                        objMyOrderVM.myOrdersPageNumber = objMyOrderVM.myOrdersPageNumber + 1
                        getMyOrdersList(shouldAnimate: true)
                    }
                }
            }
        }
        
        
    }
    
}

