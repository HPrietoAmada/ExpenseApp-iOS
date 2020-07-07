//
//  UserSearchTableViewController+TableView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/10/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UserSearchTableViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: cellID)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedUsers.count
        }
        return filteredUsers.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        }
        return false
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Allow only removing selected user
        if indexPath.section == 0 {

            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
                self.selectedUsers.remove(at: indexPath.row)
            }

            return [deleteAction]

        }
        return nil
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID)
        if section == 0 {
            cell?.textLabel?.text = "Selected Employees"
        } else {
            cell?.textLabel?.text = "Amada Employees"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCell
            if selectedUsers.count > 0 {
                if let displayName = selectedUsers[indexPath.row].DISPLAY_NAME {
                    cell.title = displayName
                }

                cell.hasBorder = selectedUsers.count - 1 != indexPath.row
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCell
            if filteredUsers.count > 0 {
                if let displayName = filteredUsers[indexPath.row].DISPLAY_NAME {
                    cell.title = displayName
                }
                cell.hasBorder = filteredUsers.count - 1 != indexPath.row
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if !selectedUsers.contains(where: { $0.USER_ID == filteredUsers[indexPath.row].USER_ID }) {
                selectedUsers.append(filteredUsers[indexPath.row])
                selectedUsers.sort(by: { $0.PREFER_NAME_FIRST ?? "" < $1.PREFER_NAME_FIRST ?? "" })
                searchBar.text = ""
            } else {
                tableView.cellForRow(at: indexPath)?.isSelected = false
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
