//
//  ExpenseModelListTableView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol TripTableViewDelegate {
    func expenseModelListTableView(_ tableView: TripTableView, didSelectRowAt indexPath: IndexPath)
}

class TripTableView: UITableView {

    var _delegate: TripTableViewDelegate?
    var _parent: UIViewController?
    var _header: String = "Trips" {
        didSet {
            
        }
    }

    let cellId: String = "expense-model-list-table-cell"
    let headerId: String = "expense-model-list-table-header"

    var models: [ExpenseModel] = [ExpenseModel]() {
        didSet {
            reloadData()
        }
    }

    var _canDelete: Bool = false {
        didSet {
            reloadData()
        }
    }

    private func setup() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .white
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        translatesAutoresizingMaskIntoConstraints = false

        register(ExpenseModelTableViewCell.self, forCellReuseIdentifier: cellId)
        register(TitleHeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: CGRect.zero, style: style)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
