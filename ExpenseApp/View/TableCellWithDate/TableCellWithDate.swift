//
//  TableCellWithDate.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/15/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

class TableCellWithDate: UITableViewCell {

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var hasBorder: Bool = true {
        didSet {
            bottomBorder.alpha = hasBorder ? 1 : 0
        }
    }

    var date: Date? {
        didSet {
            guard let date = date else {
                return
            }

            dateLabel.text = date.getFormattedDate(format: "MMM dd, yyyy")
        }
    }

    private let XPADDING: CGFloat = 20

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .placeholder
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: Border = {
        let borderView = Border()
        return borderView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        addSubview(label)
        addSubview(dateLabel)
        addSubview(bottomBorder)

        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        label.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: -10).isActive = true

        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        dateLabel.topAnchor.constraint(equalTo: label.topAnchor).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
