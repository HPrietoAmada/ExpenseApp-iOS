//
//  ExpenseSummaryTableViewCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ExpenseSummaryTableViewCell: UITableViewCell {

    var expenseSummary: ExpenseSummary? {
        didSet {

        }
    }

    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup()
    {
        selectionStyle = .none
        backgroundColor = .clear

        addSubview(nameLabel)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
