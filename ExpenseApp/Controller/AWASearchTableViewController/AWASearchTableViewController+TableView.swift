//
//  AWASearchTableViewController+TableView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/13/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//
/*
import UIKit

extension AWASearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCellWithDate.self, forCellReuseIdentifier: cellID)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCellWithDate
        if filteredModels.count > 0 {
            let filteredModel = filteredModels[indexPath.row]
            if let purpose = filteredModel.PURPOSE {
                if let awa = filteredModel.AWA_NUMBER {
                    cell.title = "(\(awa)) - \(purpose)"
                } else {
                    cell.title = purpose
                }
            }

            if let created_date_str = filteredModel.CREATED_DATE,
                let created_date = created_date_str.toDate("MM/dd/yyyy HH:mm:ss a") {
                cell.date = created_date
            }

            cell.hasBorder = filteredModels.count - 1 != indexPath.row
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAWA = filteredModels[indexPath.row]

        guard let delegate = delegate else {
            return
        }

        delegate.awaSearchTableViewControllerDelegate(self.navigationController as! NavigationController, awa: selectedAWA, done: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
*/
