//
//  ExpenseModelTableView+TableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension ExpenseTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExpenseTableViewCell
        cell.exp_dtl = expenseList[indexPath.row]
        if numberOfRows(inSection: indexPath.section) - 1 == indexPath.row { cell.bottomBorder.backgroundColor = .clear } else { cell.bottomBorder.backgroundColor = UIColor.MainColors.lightGray }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! TitleHeaderCell
        header._header = _header
        header._subtitle = _subtitle
        return header
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = _delegate else {
            return
        }
        delegate.expenseTableView(self, didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actions: [UITableViewRowAction] = [UITableViewRowAction]()

        if _canDelete {
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: handleDeleteExpenseAction)
            deleteAction.backgroundColor = UIColor.MainColors.red
            actions.append(deleteAction)
        }

        if _canUpdate {
            let updateAction = UITableViewRowAction(style: .default, title: "Update", handler: handleUpdateExpenseAction)
            updateAction.backgroundColor = UIColor.MainColors.mainColor
            actions.append(updateAction)
        }

        return actions
    }

    func handleUpdateExpenseAction(action: UITableViewRowAction, indexPath: IndexPath) {
        guard let trip = self.model.Trip, let expenses = self.model.Expenses, let parent = _parent else { return }
        let expense = expenses[indexPath.row]
        let controller = EXP_DTLViewController()
        controller._expense = expense
        controller._guestList = self.model.Guests ?? [EXP_DTL_GUESTS]()
        controller.exp_hdr = trip
        controller.canUpdate = _canUpdate
        parent.present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    /* Deletes an expense from phone state/table */
    func handleDeleteExpenseAction(action: UITableViewRowAction, indexPath: IndexPath) {

        let alertController = UIAlertController(
            title: "Deleting Expense",
            message: "Are you sure you want to delete this expense?",
            preferredStyle: .alert
        )

        // Action for deleting record from WEB_VIA2.EXP_DTL
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            guard let expenses = self.model.Expenses, let id = expenses[indexPath.row].ID else { return }
            DBManager.shared.deleteExpense(id: id) { (error) in
                if error.code >= 300 {
                    if let parent = self._parent {
                        parent.presentAlert(title: "Error", message: error.localizedDescription)
                    }
                    return
                }
                self.expenseList.remove(at: indexPath.row)
            }
        }))
        alertController.addAction(
                UIAlertAction(title: "Cancel",
                              style: .cancel,
                              handler: nil)
            )
        if let parent = _parent {
            parent.present(alertController, animated: true, completion: nil)
        }
    }
}
