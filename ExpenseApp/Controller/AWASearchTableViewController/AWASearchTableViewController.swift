//
//  AWASearchTableViewController.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/13/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//
/*
import UIKit

protocol AWASearchTableViewControllerDelegate {
    func awaSearchTableViewControllerDelegate(_ controller: NavigationController, awa: WEB_VIA2_PR_HDR, done error: Error?)
}

class AWASearchTableViewController: UIViewController {

    let cellID: String = "cell-id"
    let headerID: String = "header-id"

    var delegate: AWASearchTableViewControllerDelegate?

    var models = [WEB_VIA2_PR_HDR]()
    var filteredModels = [WEB_VIA2_PR_HDR]()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search Amada Employee..."
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var cancelNavbarButtonItem: TextNavbarButtonItem = {
        let textNavbarButtonItem = TextNavbarButtonItem("Cancel")
        textNavbarButtonItem.action = #selector(cancel)
        textNavbarButtonItem.target = self
        return textNavbarButtonItem
    }()

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
        DBManager.shared.getPR_HDR { (models, error, message) in
            if let error = error {
                print("AWA Error: \(error.localizedDescription)")
                return
            }

            guard let models = models else {
                return
            }
            self.models = models
        }

        searchBar.becomeFirstResponder()
    }

    func setup() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cancelNavbarButtonItem
        searchBar.delegate = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
*/
