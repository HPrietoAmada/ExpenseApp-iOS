//
//  ManagerExpenseController+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/27/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ManagerExpenseController: AuthViewControllerDelegate,
ExpenseTableHeaderDelegate {
    func expenseTableHeader(_ header: ExpenseTableHeader, didSelectHeaderAt section: Int) {
        collapsed[section] = !collapsed[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }

    func authViewController(_ authViewController: AuthViewController, loggedIn model: SessionModel) {
        
    }
}
