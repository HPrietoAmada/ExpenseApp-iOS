//
//  TripTableViewController.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/17/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol TripTableViewControllerDelegate {
    func tripTableViewController(_ controller: TripTableViewController, fetchData tag: Int)
}

class TripTableViewController: UIViewController {

    var tag: Int = 0

    var delegate: TripTableViewControllerDelegate?

    var models: [TripModel] = [TripModel]() {
        didSet {
            _subtitle = "\(models.count) result(s) found"
            tableView.models = models

            if let selectedTrip = expenseTableViewController.model.Trip,
                let id = selectedTrip.ID,
                let selectedExpenseModel = models.first(where: { $0.Trip?.ID == id }){
                expenseTableViewController.model = selectedExpenseModel
            }
        }
    }

    @objc private func handleCreateNew() {
        let controller = EXP_HDRViewController()
        controller._formSubmitDelegate = self
        controller.tag = 1
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    var _canCreateNew: Bool = false {
        didSet {
            if !_canCreateNew { return }
            let rightBarButtonItem = TextNavbarButtonItem("Create Trip")
            rightBarButtonItem.target = self
            rightBarButtonItem.action = #selector(handleCreateNew)
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }

    var _canSubmit: Bool = false {
        didSet {
            tableView._canSubmit = _canSubmit
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

    var _canUnsubmit: Bool = false {
        didSet {
            tableView._canUnsubmit = _canUnsubmit
        }
    }

    var _canAddNotes: Bool = false {
        didSet {
            tableView._canAddNotes = _canAddNotes
        }
    }

    let tableView: TripTableView = {
        let table = TripTableView()
        return table
    }()

    let expenseTableViewController: ExpenseTableViewController = {
        let controller = ExpenseTableViewController()
        return controller
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
