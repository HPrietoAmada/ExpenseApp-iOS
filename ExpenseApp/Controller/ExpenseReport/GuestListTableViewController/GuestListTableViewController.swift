//
//  GuestListTableViewController.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/30/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol GuestListTableViewControllerDelegate {
    func guestListTableViewController(_ controller: GuestListTableViewController, guestList: [EXP_DTL_GUESTS])
}

class GuestListTableViewController: UIViewController {

    var delegate: GuestListTableViewControllerDelegate?

    var expense: EXP_DTL? {
        didSet {
        }
    }

    var trip: EXP_HDR? {
        didSet {
            
        }
    }

    var models: [EXP_DTL_GUESTS] = [EXP_DTL_GUESTS]() {
        didSet {
            tableView.reloadData()
        }
    }

    let cellId: String = "guest-list-table-view-cell"
    let headerId: String = "guest-list-table-view-header"

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let userSearchTableViewController: UserSearchTableViewController = {
        let controller = UserSearchTableViewController()
        return controller
    }()

    lazy var addGuestNavbarItem: TextNavbarButtonItem = {
        let navbarItem = TextNavbarButtonItem("Add Guests")
        navbarItem.action = #selector(handleAddGuest)
        navbarItem.target = self
        return navbarItem
    }()

    @objc func handleAddGuest() {
        userSearchTableViewController.selectedUsers.removeAll()
        navigationController?.pushViewController(userSearchTableViewController, animated: true)
    }

    lazy var backNavbarItem: UIBarButtonItem = {
    let leftArrow: UIImage = UIImage(named: "left_navbar_arrow") ?? UIImage()
        let item = UIBarButtonItem(
            image: leftArrow,
            style: .plain,
            target: self,
            action: #selector(handleBack)
        )
        return item
    }()

    @objc func handleBack() {
        if let delegate = delegate {
            delegate.guestListTableViewController(self, guestList: models)
        }
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    private func setup() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = addGuestNavbarItem
        navigationItem.leftBarButtonItem = backNavbarItem
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: cellId)
        tableView.register(TitleHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        userSearchTableViewController._delegate = self
    }
}
