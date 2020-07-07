//
//  ExpenseModelTable.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol ExpenseTableViewDelegate {
    func expenseTableView(_ tableView: ExpenseTableView, didSelectRowAt indexPath: IndexPath)
}

class ExpenseTableView: UITableView {

    var _delegate: ExpenseTableViewDelegate?
    var _parent: UIViewController?

    let cellId: String = "expense-model-table-cell"
    let headerId: String = "expense-model-table-header"

    var model: TripModel = TripModel() {
        didSet {
            if let trip = model.Trip, let tripName = trip.TRIP_NAME {
                _subtitle = tripName
            } else {
                _subtitle = ""
            }
            guard let expenseList = model.Expenses else { return }
            self.expenseList = expenseList
        }
    }

    var expenseList: [EXP_DTL] = [EXP_DTL]() {
        didSet {
            _subtitle = "\(expenseList.count) result(s) found"
            reloadData()
        }
    }

    var _header: String = "Expenses" {
        didSet {
        }
    }

    var _subtitle: String = "No results found" {
        didSet {

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

    func setup() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .white
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        translatesAutoresizingMaskIntoConstraints = false

        register(ExpenseTableViewCell.self, forCellReuseIdentifier: cellId)
        register(TitleHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
    }

    init() {
        super.init(frame: CGRect.zero, style: .grouped)
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
