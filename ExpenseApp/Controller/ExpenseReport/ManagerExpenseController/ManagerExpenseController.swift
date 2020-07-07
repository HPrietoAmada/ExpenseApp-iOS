//
//  ManagerExpenseController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/30/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ManagerExpenseController: UIViewController {

    /* Global Variables */
    var models = [ManagerExpenseModel]() {
        didSet {
            self.collapsed = [Bool](repeating: true, count: models.count)
            tableView.reloadData()
        }
    }
    var collapsed = [Bool]()
    let cellID = "cell_id"
    let cellHeaderID = "expense_header_cell"

    @objc func handleExpenseReportCancel() {
        self.navigationController?.popViewController(animated: true)
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getManagerData()
        refreshControl.endRefreshing()
    }

    let titleView: TitleView = {
        let titleView = TitleView("Manager",
                                  subtitle: "Pending: 0 reports")
        titleView.titleTextView.font = UIFont(name: "HelveticaNeue-Bold",
                                           size: 35)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let tableBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let messageView: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.numberOfLines = 3
        label.text = "No expenses have been submitted to you"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /* Controller LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
        self.initializeViews()
        self.setNavigationBarStyle()
        getManagerData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func getManagerData() {

        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }

        titleView.subtitle = "Norman Liu"

        DBManager.shared.getManagerEmployeeTripModels(id: 580, { (models, error) in
            if error.code >= 300 {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            guard let models = models else {
                return
            }
            self.messageView.alpha = models.count == 0 ? 1 : 0
            self.models = models
        })
    }

    /* Customizes the UINavigationBar */
    func setNavigationBarStyle() {
    }

    func initializeViews() {
        // Set Background Color
        self.view.backgroundColor = UIColor.white

        // Add View Components to View
        self.view.addSubview(self.titleView)
        self.view.addSubview(self.tableBackground)
        self.view.addSubview(self.tableView)
        view.addSubview(messageView)

        // TitleView Constraints
        self.titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        self.titleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Table Background Constraints
        self.tableBackground.topAnchor.constraint(equalTo: self.titleView.bottomAnchor,
                                                  constant: 25).isActive = true
        self.tableBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Expense Table Constraints
        self.tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor,
                                            constant: 25).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        messageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        messageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    /* Creates a Controller that alerts user upon reports submition */
    func reportsSubmitAlert() {
        let alertController = UIAlertController(title: "SUBMIT mileage expenses for management approval?",
                                                message: "Press 'Submit' to continue",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit",
                                         style: .default) { (action)
            in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        self.present(alertController, animated: true, completion: nil)
    }

    /* Check if user is on 'Lowe Power Mode' */
    func lowerPowerModeCheck() {
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            self.batteryModeAlert()
        } else {
            self.reportsSubmitAlert()
        }
    }
}
