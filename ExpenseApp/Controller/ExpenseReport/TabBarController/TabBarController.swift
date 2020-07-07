//
//  TabBarController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/11/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var model: APIModel = APIModel() {
        didSet {
            if let expenseModels = model.ExpenseModels {
                print("ExpenseModels: \(expenseModels.count)")
                let openTrips = expenseModels.filter({
                    $0.Trip?.EXP_STATUS == "OPEN" ||
                    $0.Trip?.EXP_STATUS == "REJECTED"
                })
                let submittedTrips = expenseModels.filter({
                    $0.Trip?.EXP_STATUS == "SUBMITTED" ||
                    $0.Trip?.EXP_STATUS == "MGR_APPROVED" ||
                    $0.Trip?.EXP_STATUS == "ACC_APPROVED"
                })
                let closedTrips = expenseModels.filter({
                    $0.Trip?.EXP_STATUS == "CLOSED"
                })
                openTripController.models = openTrips
                submittedTripController.models = submittedTrips
                closedTripController.models = closedTrips
            }
            if let _ = model.ManagerExpenseModels {
                // managerController.models = managerExpenseModelList
            }
        }
    }

    var _viewControllers: [UIViewController] = [UIViewController]() {
        didSet {
            viewControllers = _viewControllers
        }
    }

    let openTripController: TripTableViewController = {
        let controller = TripTableViewController()
        controller.tabBarItem.title = "Trips"
        controller._canUpdate = true
        controller._canDelete = true
        controller._canCreateNew = true
        controller._canSubmit = true
        controller._canAddNotes = true
        controller.tabBarItem.image = UIImage(named: "wallet_empty")
        controller.tabBarItem.selectedImage = UIImage(named: "wallet_filled")
        return controller
    }()

    let submittedTripController: TripTableViewController = {
        let controller = TripTableViewController()
        controller._canUnsubmit = true
        controller.tabBarItem.title = "Submissions"
        controller.tabBarItem.image = UIImage(named: "hourglass_empty")
        controller.tabBarItem.selectedImage = UIImage(named: "hourglass_filled")
        controller._header = "Submitted"
        controller._canAddNotes = true
        return controller
    }()

    let closedTripController: TripTableViewController = {
        let controller = TripTableViewController()
        controller._header = "Past Trips"
        controller.tabBarItem.title = "History"
        controller.tabBarItem.selectedImage = UIImage(named: "history_filled")
        controller.tabBarItem.image = UIImage(named: "history_empty")
        return controller
    }()

    let managerController: ManagerExpenseController = {
        let controller = ManagerExpenseController()
        controller.tabBarItem.title = "Manager"
        controller.tabBarItem.selectedImage = UIImage(named: "manager_filled")
        controller.tabBarItem.image = UIImage(named: "manager_empty")
        return controller
    }()

    let settingsController: SettingsViewController = {
        let controller = SettingsViewController()
        controller.tabBarItem.title = "Settings"
        controller.tabBarItem.selectedImage = UIImage(named: "settings")
        controller.tabBarItem.image = UIImage(named: "settings")
        return controller
    }()

    let createTabButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.MainColors.mainColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(handleCenterButtonClick), for: .touchUpInside)

        let imageDims: CGFloat = 20
        let image = UIImage(named: "car")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: imageDims).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageDims).isActive = true

        let dims: CGFloat = 50
        button.layer.cornerRadius = dims/2
        button.heightAnchor.constraint(equalToConstant: dims).isActive = true
        button.widthAnchor.constraint(equalToConstant: dims).isActive = true

        button.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        return button
    }()

    var isHidden: Bool = false {
        didSet {
            tabBar.isHidden = isHidden
            createTabButton.alpha = isHidden ? 0 : 1
        }
    }

    /**
     * Controller LifeCycle Methods
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func authenticateUser() {
        let authViewController = AuthViewController()
        authViewController.delegate = self
        present(
            NavigationController(
                rootViewController: authViewController),
                animated: true,
                completion: nil
        )
    }

    public func fetchData() {
        CoreDataManager.shared.getCurrentUser() { (coreUser, error) in
            guard let user = coreUser else {
                self.authenticateUser()
                return
            }
            DBManager.shared.getAPIModel(uid: Int(user.user_id)) { (apiModel, err) in
                guard let apiModel = apiModel else {
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    return
                }
                self.model = apiModel
                if let tableColRef = apiModel.TableColRef {
                    self.setAAI_TABLE_COLUMN_REF(tableColRef: tableColRef)
                }
            }
        }
        // Get WEB_IT.USERS and store them in cache
        DBManager.shared.getUsers { (users, error) in
            
        }
    }
    
    /**
     * View Component Initializer
     */
    fileprivate func setup() {
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = UIColor.MainColors.mainColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.MainColors.lightGray.cgColor

        viewControllers = [
            NavigationController(rootViewController: openTripController),
            NavigationController(rootViewController: submittedTripController),
            NavigationController(rootViewController: closedTripController),
            NavigationController(rootViewController: managerController),
            NavigationController(rootViewController: settingsController)
        ]
    }
}
