//
//  UserTableViewCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/10/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

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

    private let XPADDING: CGFloat = 20

    let label: TextView = {
        let textView = TextView()
        textView.textAlignment = .left
        textView.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        textView.padding = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 20,
            right: 0
        )
        return textView
    }()

    let bottomBorder: Border = {
        let border = Border()
        return border
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        addSubview(label)
        addSubview(bottomBorder)

        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
