//
//  ExpenseController+Table.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation

extension ExpenseTableViewControllerOLD: UITableViewDelegate, UITableViewDataSource, ExpenseTableHeaderDelegate {

    func expenseTableHeader(_ header: ExpenseTableHeader, didSelectHeaderAt section: Int) {
        let controller = EXP_HDRViewController()

        if let trip = expenseModels[section].Trip {
            controller.trip = trip
        }
        if let expenses = expenseModels[section].Expenses {
            controller.expenseList = expenses
        }
        controller._canUpdate = self.canUpdate

        let navController = NavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }

    /* Initializes TableView */
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: self.cellID)
        tableView.register(ExpenseTableHeader.self, forHeaderFooterViewReuseIdentifier: self.cellHeaderID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)

        tableView.addSubview(refreshControl)
    }

    /* Enables Swipe to delete functionality */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canUpdate
    }

    /* Sets the action buttons upon left swipe of table */
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if !canUpdate {
            return nil
        }

        // DELETE
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: handleDeleteExpenseAction)
        deleteAction.backgroundColor = UIColor.MainColors.red

        return [deleteAction]
    }

    /* Deletes an expense from phone state/table */
    func handleDeleteExpenseAction(action: UITableViewRowAction, indexPath: IndexPath) {
        if lowPowerModeON() {
            presentAlert(title: "LOW POWER MODE ON", message: "Turn OFF \"Low Power Mode\" before deleting this Expense")
            return
        }

        let alertController = UIAlertController(title: "Deleting Expense", message: "Are you sure you want to delete this expense?", preferredStyle: .alert)

        guard let expenses = expenseModels[indexPath.section].Expenses,
            let expenseID = expenses[indexPath.row].ID else {
            return
        }
        // Action for deleting record from WEB_VIA2.EXP_DTL
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            DBManager.shared.deleteExpense(id: expenseID) { (error) in
                if error.code >= 300 {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                guard var expenses = self.expenseModels[indexPath.section].Expenses else {
                    return
                }
                expenses.remove(at: indexPath.row)
                self.tableView.reloadData()
                /*
                if let newTotalAmount = self.expenseModels[indexPath.section].getExpenseTotal() {
                    let headerCell = self.tableView.headerView(forSection: indexPath.section) as! ExpenseTableHeader
                    headerCell.detail = "$\(newTotalAmount)"
                }*/
            }
        }))

        alertController.addAction(
            UIAlertAction(title: "Cancel",
                          style: .cancel,
                          handler: nil)
        )
        present(alertController, animated: true, completion: nil)
    }

    /* Allows user to edit the desired report */
    func editMileageExpense(indexPath: IndexPath) {
    }

    /* Submits this single report */
    func submitMileageExpense(indexPath: IndexPath) {
    }

    /* User selected row at index: 'indexPath.row' */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EXP_DTLViewController()
        if let trip = expenseModels[indexPath.section].Trip,
            let expenses = expenseModels[indexPath.section].Expenses {
            controller._expense = expenses[indexPath.row]
            controller.exp_hdr = trip
        }
        controller.canUpdate = self.canUpdate
        controller.createMode = false

        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    /* Sets the custom cell's view */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! ExpenseTableViewCell
        if let expenses = expenseModels[indexPath.section].Expenses {
            cell.exp_dtl = expenses[indexPath.row]
        }
        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row { cell.bottomBorder.backgroundColor = .clear } else { cell.bottomBorder.backgroundColor = UIColor.MainColors.lightGray }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.cellHeaderID) as! ExpenseTableHeader
        if let trip = expenseModels[section].Trip {
            cell.exp_hdr = trip
        }
        cell.section = section
        cell.delegate = self
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }*/

    /* Sets the number of sections in tableView */
    func numberOfSections(in tableView: UITableView) -> Int {
        return expenseModels.count
    }

    /* Sets the number of rows in section */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let expenses = expenseModels[section].Expenses {
            return expenses.count
        }
        return 0
    }
}
