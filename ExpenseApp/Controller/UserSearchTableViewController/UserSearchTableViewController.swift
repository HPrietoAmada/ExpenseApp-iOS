//
//  UserSearchTableViewController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/9/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol UserSearchTableViewControllerDelegate {
    func userSearchTableViewController(_ controller: UserSearchTableViewController, selected users: [User], error: NSError)
    func userSearchTableViewController(_ controller: UserSearchTableViewController, deleted user: User)
}
class UserSearchTableViewController: UIViewController {

    let cellID: String = "cell_id"
    let headerID: String = "header_id"
    let addGuestFooterCellID: String = "add-guest-footer-cell-id"

    var _delegate: UserSearchTableViewControllerDelegate?

    var selectedUsers: [User] = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    var users = [User]()
    var filteredUsers: [User] = [User]() {
        didSet {
            tableView.reloadData()
        }
    }

    var guests: [EXP_DTL_GUESTS] = [EXP_DTL_GUESTS]() {
        didSet {
            
        }
    }

    var _rightNavbarItemTitle: String = "" {
        didSet {
            rightNavbarItem.title = _rightNavbarItemTitle
        }
    }

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search Amada Employee..."
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var rightNavbarItem: TextNavbarButtonItem = {
        let item = TextNavbarButtonItem("Done")
        item.target = self
        item.action = #selector(handleRightNavbarItemClicked)
        return item
    }()

    @objc func handleRightNavbarItemClicked() {
        guard let delegate = _delegate else { return }
        delegate.userSearchTableViewController(
            self,
            selected: selectedUsers,
            error: NSError(domain: "", code: 200, userInfo: [ NSLocalizedDescriptionKey: "success" ]
        ))
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        setupTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DBManager.shared.getUsers { (users, error) in
            guard let users = users else {
                if let delegate = self._delegate {
                    delegate.userSearchTableViewController(self, selected: self.selectedUsers, error: error)
                }
                return
            }
            print("Users: \(users.count)")
            self.users = users
            self.filteredUsers = users
        }

        searchBar.becomeFirstResponder()
    }

    func setup() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = rightNavbarItem
        searchBar.delegate = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
