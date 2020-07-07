//
//  ManagerExpenseController+Table.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/30/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ManagerExpenseController: UITableViewDelegate, UITableViewDataSource {

    /* Initializes TableView */
    func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExpenseModelTableViewCell.self,
                                forCellReuseIdentifier: self.cellID)

        tableView.register(ExpenseTableHeader.self,
                                forHeaderFooterViewReuseIdentifier: self.cellHeaderID)

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        tableView.addSubview(refreshControl)
    }

    /* Enables Swipe to delete functionality */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    /* Sets the action buttons upon left swipe of table */
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // REJECTED
        let rejectAction = UITableViewRowAction(style: .default,
                                                title: "Reject",
                                                handler: handleRejectAction)
        rejectAction.backgroundColor = UIColor.MainColors.red

        // SUBMITTED
        let approveAction = UITableViewRowAction(style: .default,
                                                title: "Approve",
                                                handler: handleApproveAction)
        approveAction.backgroundColor = UIColor.MainColors.green
        return [rejectAction, approveAction]
    }

    /*
     * Called when user swipes left on a tableCell and selects "Reject"
     */
    func handleRejectAction(action: UITableViewRowAction, indexPath: IndexPath) {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }

        let rejectMessageAlertController = UIAlertController(title: "Reject Reason",
                                                             message: "What's the reason for rejecting this expense?",
                                                             preferredStyle: .alert)
        rejectMessageAlertController.addTextField(configurationHandler: handleAddTextFieldToAlertController)
        rejectMessageAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        rejectMessageAlertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            guard let textFields = rejectMessageAlertController.textFields,
                let rejectTextField = textFields.first(where: { $0.tag == 1 }),
                let reason = rejectTextField.text else {
                    return
            }
            if let expenses = self.models[indexPath.section].expenses, let trip = expenses[indexPath.row].Trip, let tripID = trip.ID {
                CoreDataManager.shared.getCurrentUser { (coreUser, error) in
                    if let coreUser = coreUser, let username = coreUser.username {
                        DBManager.shared.rejectTrip(id: tripID, username: username, department: "MGR", reason: reason) { (err) in
                            self.handleTripStatusChanged(trip: trip, error: err, indexPath: indexPath)
                        }
                    }
                }
            }
        }))
        present(rejectMessageAlertController, animated: true, completion: nil)
        return
    }

    func handleTripStatusChanged(trip: EXP_HDR?, error: NSError, indexPath: IndexPath) {
        if error.code >= 300 {
            self.presentAlert(title: "Error", message: "\(error.localizedDescription) Make sure you're connection to Amada's VPN")
            return
        }
        if let _ = self.models[indexPath.section].expenses {
            self.models[indexPath.section].expenses?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
    }

    /*
     * Sets the styling for textField displayed in AlertController presented when manager needs to enter
     *  a reason for rejecting an expense.
     */
    func handleAddTextFieldToAlertController(textField: UITextField) {
        textField.tag = 1
        textField.placeholder = "Enter a reason..."
        textField.autocapitalizationType = .sentences
        textField.font = UIFont(name: "HelveticaNeue", size: 16)
    }

    /*
     * Called when user swipes left on a tableCell and selects "Approve"
     */
    func handleApproveAction(action: UITableViewRowAction, indexPath: IndexPath) {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }

        let alertController = UIAlertController(title: "Approving Expense", message: "Are you sure you want to approve this Expense?", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (action) in
            guard let expenses = self.models[indexPath.section].expenses,
                let trip = expenses[indexPath.row].Trip,
                let tripID = trip.ID else {
                    return
            }
            CoreDataManager.shared.getCurrentUser { (coreUser, error) in
                guard let coreUser = coreUser, let username = coreUser.username else {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                DBManager.shared.submitTrip(id: tripID, username: username, status: "MGR_APPROVED") { (err) in
                    self.handleTripStatusChanged(trip: trip, error: err, indexPath: indexPath)
                }
            }
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    /* User selected row at index: 'indexPath.row' */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ExpenseTableViewController()
        if let userModels = self.models[indexPath.section].expenses {
            controller.model = userModels[indexPath.row]
        }
        navigationController?.pushViewController(controller, animated: true)
    }

    /* Sets the custom cell's view */
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! ExpenseModelTableViewCell
        if let expenses = self.models[indexPath.section].expenses {
            cell.expenseModel = expenses[indexPath.row]
        }

        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row { cell.bottomBorder.backgroundColor = .clear } else { cell.bottomBorder.backgroundColor = UIColor.MainColors.lightGray }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.cellHeaderID) as! ExpenseTableHeader
        cell.delegate = self
        cell.section = section
        if let displayName = self.models[section].displayName {
            cell.title = displayName
        }
        if let expenses = self.models[section].expenses {
            cell.detail = "\(expenses.count)"
        }
        return cell
    }

    /* Sets the number of sections in tableView */
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    /* Sets the number of rows in section */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let expenses = models[section].expenses {
            return collapsed[section] ? 0 : expenses.count
        }
        return 0
    }
}
