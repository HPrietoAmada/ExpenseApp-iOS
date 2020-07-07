//
//  FooterButtonView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 10/18/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TableFooterButtonView: UITableViewHeaderFooterView {

    let XBOUNDS: CGFloat = 30
    let YBOUNDS: CGFloat = 15

    var title: String = "Button" {
        didSet {
            button.title = title
        }
    }

    lazy var button: AmadaButton = {
        let amadaButton = AmadaButton("Begin Creating Expenses")
        return amadaButton
    }()

    let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        addSubview(button)
        addSubview(topBorder)

        translatesAutoresizingMaskIntoConstraints = false

        button.removeConstraints(button.constraints)
        button.heightAnchor.constraint(equalTo: heightAnchor, constant: -(YBOUNDS * 2)).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: widthAnchor, constant: -(XBOUNDS * 2)).isActive = true

        topBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBorder.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
