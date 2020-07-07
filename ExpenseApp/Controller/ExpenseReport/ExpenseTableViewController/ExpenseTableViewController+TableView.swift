//
//  ExpenseTableView+TableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/18/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension ExpenseTableViewController: ExpenseTableViewDelegate, UIViewControllerFormSubmitDelegate {

    func viewController(_ viewController: UIViewController, formSubmitError error: NSError, tag: Int) {
        if error.code >= 300 { return }
        // guard let trip = self.model.Trip, let tripId = trip.ID else { return }
        if let tabController = self.tabBarController as? TabBarController {
            tabController.fetchData()
        }
        return
            /*
        DBManager.shared.getTripModel(id: tripId) { (expenseModel, error) in
            guard let expenseModel = expenseModel else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            self.model = expenseModel
        }*/
    }

    func expenseTableView(_ tableView: ExpenseTableView, didSelectRowAt indexPath: IndexPath) {
        guard let trip = model.Trip, let expenses = model.Expenses else { return }
        let controller = EXP_DTLViewController()
        controller.exp_hdr = trip
        controller._expense = expenses[indexPath.row]
        if let guests = model.Guests {
            controller._guestList = guests.filter({ $0.expDtlId == expenses[indexPath.row].ID })
        }
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }
}
