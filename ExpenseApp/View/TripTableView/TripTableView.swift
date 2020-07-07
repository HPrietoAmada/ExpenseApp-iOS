//
//  ExpenseModelListTableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol TripTableViewDelegate {
    func tripTableView(_ tableView: TripTableView, didSelectRowAt indexPath: IndexPath)
    func tripTableView(_ tableView: TripTableView, tripUpdated indexPath: IndexPath)
}

class TripTableView: UITableView {

    var _delegate: TripTableViewDelegate?
    var _parent: UIViewController?
    var _header: String = "Trips" {
        didSet {
            
        }
    }

    var _subtitle: String = "0 result(s) found" {
        didSet {

        }
    }

    let cellId: String = "expense-model-list-table-cell"
    let headerId: String = "expense-model-list-table-header"

    var models: [TripModel] = [TripModel]() {
        didSet {
            _subtitle = "\(models.count) result(s) found"
            reloadData()
        }
    }

    var _canDelete: Bool = false {
        didSet {
            
        }
    }

    var _canUpdate: Bool = false {
        didSet {

        }
    }

    var _canSubmit: Bool = false {
        didSet {
            
        }
    }

    var _canUnsubmit: Bool = false {
        didSet {
            
        }
    }

    var _canAddNotes: Bool = false {
        didSet {
            
        }
    }

    lazy var _refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if let delegate = _delegate {
            delegate.tripTableView(self, tripUpdated: IndexPath(row: 0, section: 0))
        }
        _refreshControl.endRefreshing()
    }

    fileprivate func setup() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .white
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(_refreshControl)
        register(ExpenseModelTableViewCell.self, forCellReuseIdentifier: cellId)
        register(TitleHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
    }

    init() {
        super.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        setup()
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: CGRect.zero, style: style)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
