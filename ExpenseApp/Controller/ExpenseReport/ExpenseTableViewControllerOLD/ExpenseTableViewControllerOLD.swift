//
//  ExpenseController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreData

class ExpenseTableViewControllerOLD: UIViewController {

    /* Global Variables */
    var expenseModels = [TripModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    let cellID = "cell_id"
    let cellHeaderID = "expense_header_cell"
    var canUpdate: Bool = true
    
    @objc func handleExpenseReportCancel() {
        self.navigationController?.popViewController(animated: true)
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        checkForUserSession()
        refreshControl.endRefreshing()
    }

    let titleView: TitleView = {
        let titleView = TitleView("Open Expenses", subtitle: "")
        titleView.titleTextView.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
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
        label.text = "No expenses created"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.MainColors.mainColor
        button.setImage(UIImage(named: "plus32")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCreateTrip), for: .touchUpInside)
        button.addShadow()

        let buttonDims: CGFloat = 60
        button.layer.cornerRadius = buttonDims/2
        button.heightAnchor.constraint(equalToConstant: buttonDims).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonDims).isActive = true
        return button
    }()

    let progressIndicator: ProgressIndicator = {
        let progressIndicator = ProgressIndicator(text: "Fetching Expenses...")
        return progressIndicator
    }()

    /* Controller LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        progressIndicator.show()
        saveCoreDataExpenses { (error) in
            self.progressIndicator.hide()
            self.checkForUserSession()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeTableView()
        initializeViews()
        setNavigationBarStyle()

        if self.lowPowerModeON() {
            self.batteryModeAlert()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let tabBarController = tabBarController as? TabBarController {
            tabBarController.isHidden = false
        }
    }

    func checkForUserSession() {
        CoreDataManager.shared.getCurrentUser() { (coreUser, error) in
            guard let user = coreUser else {
                let authViewController = AuthViewController()
                authViewController.delegate = self
                present(NavigationController(rootViewController: authViewController), animated: true, completion: nil)
                return
            }
            if let displayName = user.display_name {
                self.titleView.subtitle = displayName
            }
            self.expenseModels = []
            DBManager.shared.getAPIModel(uid: Int(user.user_id)) { (apiModel, err) in
                guard let apiModel = apiModel else {
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    return
                }
                if let tableColRef = apiModel.TableColRef {
                    self.setAAI_TABLE_COLUMN_REF(tableColRef: tableColRef)
                }
                if let expenseModels = apiModel.ExpenseModels {
                    self.messageView.alpha = expenseModels.count == 0 ? 1 : 0
                    self.expenseModels = expenseModels
                }
            }
        }
    }

    /*
     Purpose
     - Fetches all Trips(WEB_VIA2.EXP_HDR) and Expenses(WEB_VIA2.EXP_DTL) that are stored locally in
        the user's device and saves them in oracle.

     */
    func saveCoreDataExpenses(_ completionHandler: StatusReturned? = nil) {
        CoreDataManager.shared.getExpenseCoreModels { (coreExpenseModels, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }
            guard let coreModels = coreExpenseModels else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unable to delete expenses from iPhone"]))
                return
            }

            if coreModels.count == 0 {
                completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "No expenses saved in iPhone to delete"]))
                return
            }
            DBManager.shared.createTripModels(models: TripModel().createListFromCoreModels(coreModels)) { (err) in
                if err.code < 300 {
                    CoreDataManager.shared.deleteAllExpenseCoreModels()
                }
                completionHandler?(err)
            }
        }
    }

    func getCoreDataExpenses() {
        // Get from local storage
        CoreDataManager.shared.getExpenseCoreModels { (models, error) in
            if let error = error {
                self.displayMessageView(message: "\(error.localizedDescription) Make sure you're connected to Amada VPN.")
                return
            }
        }
    }

    func getExpensesTotal() -> Double {

        var total = 0.0

        expenseModels.forEach { (expenseModel) in
            guard let expenses = expenseModel.Expenses else {
                return
            }

            expenses.forEach({ (expense) in
                if let total_amount = expense.TOTAL_AMOUNT {
                    total = total + total_amount
                }
            })
        }
        return total
    }

    lazy var closeNavbarButtonItem: CloseNavbarButtonItem = {
        let closeNavbarButtonItem = CloseNavbarButtonItem()
        closeNavbarButtonItem.action = #selector(close)
        closeNavbarButtonItem.target = self
        return closeNavbarButtonItem
    }()

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    /* Customizes the UINavigationBar */
    func setNavigationBarStyle() {
        if !canUpdate {
            navigationItem.leftBarButtonItem = closeNavbarButtonItem
            return
        }
        /* Add Buttons to NavigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,
                                                                 target: self,
                                                                 action: #selector(handleNavigationBarAdd))
         */
    }

    func initializeViews() {
        // Set Background Color
        self.view.backgroundColor = UIColor.white

        // Add View Components to View
        view.addSubview(titleView)
        view.addSubview(tableBackground)
        view.addSubview(tableView)
        view.addSubview(messageView)
        view.addSubview(progressIndicator)

        // Desired component widths on view

        // TitleView Constraints
        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Table Background Constraints
        tableBackground.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 25).isActive = true
        tableBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Expense Table Constraints
        tableView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 25).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        messageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        messageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        messageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        if canUpdate {
            view.addSubview(createButton)
            createButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110).isActive = true
        }
    }

    /* Creates a Controller that alerts user upon reports submition */
    func reportsSubmitAlert() {
        let alertController = UIAlertController(title: "SUBMIT mileage expenses for management approval?",
                                                message: "Press 'Submit' to continue",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)

        let submitAction = UIAlertAction(title: "Submit",
                                         style: .default) { (action) in

            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }

    /* Check if user is on 'Lowe Power Mode' */
    func lowerPowerModeCheck() {
        if ProcessInfo.processInfo.isLowPowerModeEnabled {
            self.batteryModeAlert()
        } else {
            self.reportsSubmitAlert()
        }
    }

    func deleteExpense(index: Int) {
        /*
        let expense = self.expenses[index]

        // remove company from table
        self.expenses.remove(at: index)

        // delete company from coreData
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(expense)

        // actually deletes object from tableView
        do {
            try context.save()
        } catch _ {
            print("Save error.")
        }
         */
    }
}
