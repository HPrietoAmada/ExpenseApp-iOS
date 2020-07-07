//
//  ExpenseTableViewController.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/18/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol ExpenseTableViewControllerDelegate {
    func expenseTableViewController(_ controller: ExpenseTableViewController, fetchData tag: Int)
}

class ExpenseTableViewController: UIViewController {

    var delegate: ExpenseTableViewControllerDelegate?

    var model: TripModel = TripModel() {
        didSet {
            tableView.model = model
        }
    }

    @objc private func handleAddExpense() {
        guard let trip = model.Trip else { return }
        let controller = EXP_DTLViewController()
        controller.exp_hdr = trip
        controller._formSubmitDelegate = self
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    var _canAddExpense: Bool = false {
        didSet {
            if !_canAddExpense { return }
            let rightBarButtonItem = TextNavbarButtonItem("Add Expense")
            rightBarButtonItem.target = self
            rightBarButtonItem.action = #selector(handleAddExpense)
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }

    var _canUpdate: Bool = false {
        didSet {
            tableView._canUpdate = _canUpdate
        }
    }

    var _canDelete: Bool = false {
        didSet {
            tableView._canDelete = _canDelete
        }
    }

    var _header: String = "Trips" {
        didSet {
            tableView._header = _header
        }
    }

    var _subtitle: String = "" {
        didSet {
            tableView._subtitle = _subtitle
        }
    }

    let tableView: ExpenseTableView = {
        let table = ExpenseTableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    fileprivate func setup() {
        view.addSubview(tableView)

        tableView._delegate = self
        tableView._parent = self
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
