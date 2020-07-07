//
//  GuestListTableViewController+TableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/1/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension GuestListTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableCell
        cell.selectionStyle = .none
        if let guestName: String = models[indexPath.row].guestName {
            cell.title = guestName
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleHeaderCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! TitleHeaderCell
        header._header = "Guests"
        header._subtitle = "\(self.models.count) guest(s) added"
        return header
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var actions: [UITableViewRowAction] = [UITableViewRowAction]()

        let deleteAction: UITableViewRowAction = UITableViewRowAction(
            style: .default,
            title: "Delete",
            handler: handleDeleteGuest
        )
        deleteAction.backgroundColor = .red
        actions.append(deleteAction)

        return actions
    }

    private func handleDeleteGuest(_ rowAction: UITableViewRowAction, _ indexPath: IndexPath) {
        let guest: EXP_DTL_GUESTS = models[indexPath.row]
        // Delete guest from database if expense already created
        if let _ = expense, let guestId: Int = guest.id {
            DBManager.shared.deleteGuest(guestId) { (error) in
                if error.code >= 300 {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                self.models.remove(at: indexPath.row)
            }
            return
        }
        // Only remove from table for new expenses in creation process
        self.models.remove(at: indexPath.row)
    }
}
