//
//  TripTableViewController+TableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/17/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation
import UIKit

extension TripTableViewController: TripTableViewDelegate {
    func tripTableView(_ tableView: TripTableView, tripUpdated indexPath: IndexPath) {
        if let tabController = self.tabBarController as? TabBarController {
            tabController.fetchData()
        }
    }
    func tripTableView(_ tableView: TripTableView, didSelectRowAt indexPath: IndexPath) {
        expenseTableViewController.model = models[indexPath.row]
        expenseTableViewController._canDelete = _canDelete
        expenseTableViewController._canUpdate = _canUpdate
        expenseTableViewController._canAddExpense = _canCreateNew
        navigationController?.pushViewController(expenseTableViewController, animated: true)
    }
}
