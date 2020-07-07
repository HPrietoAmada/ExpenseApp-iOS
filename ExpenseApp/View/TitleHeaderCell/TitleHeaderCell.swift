//
//  TitleHeaderCell.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/9/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleHeaderCell: UITableViewHeaderFooterView {

    private let BOUNDS: CGFloat = 20

    var _backgroundColor: UIColor = .white {
        didSet {
            view.backgroundColor = _backgroundColor
        }
    }

    var _header: String = "" {
        didSet {
            self.titleLabel.text = _header
        }
    }

    var _subtitle: String = "" {
        didSet {
            self.subtitleLabel.text = _subtitle
        }
    }

    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /* View Components */
    let titleLabel: TextView = {
        let textView = TextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.textContainer.maximumNumberOfLines = 2
        textView.font = UIFont(name: "HelveticaNeue-Medium", size: 32)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let subtitleLabel: TextView = {
        let textView = TextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.font = UIFont(name: "HelveticaNeue", size: 18)
        textView.textContainer.maximumNumberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    /* Constructor for View */

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    fileprivate func setup() {
        addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: BOUNDS).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -BOUNDS).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
