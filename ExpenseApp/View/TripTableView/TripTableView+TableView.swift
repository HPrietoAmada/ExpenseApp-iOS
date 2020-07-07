//
//  ExpenseModelListTableView+TableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension TripTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId,
            for: indexPath
            ) as! ExpenseModelTableViewCell
        cell.expenseModel = models[indexPath.row]
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
        delegate.tripTableView(self, didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actions: [UITableViewRowAction] = [UITableViewRowAction]()
        if _canAddNotes {
            let addNotesAction = UITableViewRowAction(
                style: .normal,
                title: "Notes",
                handler: handleAddNotesTripAction
            )
            addNotesAction.backgroundColor = UIColor.MainColors.lightColor
            actions.append(addNotesAction)
        }
        if _canUnsubmit {
            let unsubmitAction = UITableViewRowAction(
                style: .normal,
                title: "Unsubmit",
                handler: handleUnsubmitTripAction
            )
            unsubmitAction.backgroundColor = UIColor.MainColors.darkGray
            actions.append(unsubmitAction)
        }
        if let expenses = self.models[indexPath.row].Expenses {
            if _canSubmit && expenses.count > 0 {
                let submitAction = UITableViewRowAction(
                    style: .normal,
                    title: "Submit",
                    handler: handleSubmitTripAction
                )
                submitAction.backgroundColor = UIColor.MainColors.green
                actions.append(submitAction)
            }
        }
        if _canDelete {
            let deleteAction = UITableViewRowAction(
                style: .normal,
                title: "Delete",
                handler: handleDeleteTripAction
            )
            deleteAction.backgroundColor = UIColor.MainColors.red
            actions.append(deleteAction)
        }
        if _canUpdate {
            let updateAction = UITableViewRowAction(
                style: .normal,
                title: "Update",
                handler: handleUpdateTripAction
            )
            updateAction.backgroundColor = UIColor.MainColors.mainColor
            actions.append(updateAction)
        }
        return actions
    }

    private func handleAddNotesTripAction(action: UITableViewRowAction, indexPath: IndexPath) {
        guard let trip = models[indexPath.row].Trip, let parent = _parent else { return }
        let controller = MessageViewController()
        controller.trip = trip
        parent.present(
            NavigationController(rootViewController: controller),
            animated: true,
            completion: nil
        )
        if let delegate = _delegate {
            delegate.tripTableView(self, tripUpdated: indexPath)
        }
    }

    private func handleUnsubmitTripAction(action: UITableViewRowAction, indexPath: IndexPath) {
        guard let trip = models[indexPath.row].Trip, let id = trip.ID, let parent = _parent else { return }
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser, let username = user.username else {
                parent.presentAlert(
                    title: "Error",
                    message: error.localizedDescription
                )
                return
            }
            DBManager.shared.statusTrip(id: id, username: username, status: "OPEN") { (err) in
                if err.code >= 300 {
                    parent.presentAlert(
                        title: "Error",
                        message: err.localizedDescription
                    )
                    return
                }
                self.models.remove(at: indexPath.row)
                if let delegate = self._delegate {
                    delegate.tripTableView(self, tripUpdated: indexPath)
                }
            }
        }
    }

    private func handleSubmitTripAction(action: UITableViewRowAction, indexPath: IndexPath) {
        guard let trip = models[indexPath.row].Trip, let id = trip.ID, let parent = _parent else { return }
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser, let username = user.username else {
                parent.presentAlert(
                    title: "Error",
                    message: error.localizedDescription
                )
                return
            }
            DBManager.shared.submitTrip(id: id, username: username, status: "SUBMITTED") { (err) in
                if err.code >= 300 {
                    parent.presentAlert(
                        title: "Error",
                        message: err.localizedDescription
                    )
                    return
                }
                self.models.remove(at: indexPath.row)
                if let delegate = self._delegate {
                    delegate.tripTableView(self, tripUpdated: indexPath)
                }
            }
        }
    }

    private func handleUpdateTripAction(action: UITableViewRowAction, indexPath: IndexPath) {
        guard let trip = models[indexPath.row].Trip, let parentController = _parent else { return }
        let controller: EXP_HDRViewController = EXP_HDRViewController()
        controller.trip = trip
        parentController.present(
            NavigationController(rootViewController: controller),
            animated: true,
            completion: nil
        )
    }
    
    func handleDeleteTripAction(action: UITableViewRowAction, indexPath: IndexPath) {
        let alertController = UIAlertController(
            title: "Deleting Trip",
            message: "Are you sure you want to delete this trip?",
            preferredStyle: .alert
        )
        // Action for deleting record from WEB_VIA2.EXP_DTL
        alertController.addAction(
            UIAlertAction(
                title: "Delete",
                style: .default,
                handler: { (action) in
            guard let trip = self.models[indexPath.row].Trip,
                let tripId = trip.ID else {
                return
            }
            DBManager.shared.deleteTrip(id: tripId) { (error) in
                if error.code >= 300 {
                    if let parent = self._parent {
                        parent.presentAlert(
                            title: "Error",
                            message: error.localizedDescription
                        )
                    }
                    return
                }
                self.models.remove(at: indexPath.row)
            }
        }))
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        )
        if let parent = _parent {
            parent.present(
                alertController,
                animated: true,
                completion: nil
            )
        }
    }
}
