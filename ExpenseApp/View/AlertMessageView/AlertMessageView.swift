//
//  AlertView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/21/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

class AlertMessageView: UIView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }

    var titleFont: String = "HelveticaNeue-Medium" {
        didSet {
            titleLabel.font = UIFont(name: titleFont, size: titleFontSize)
        }
    }

    var titleFontSize: CGFloat = 18 {
        didSet {
            titleLabel.font = UIFont(name: titleFont, size: titleFontSize)
        }
    }

    var messageFont: String = "HelveticaNeue" {
        didSet {
            messageLabel.font = UIFont(name: messageFont, size: messageFontSize)
        }
    }

    var messageFontSize: CGFloat = 16 {
        didSet {
            messageLabel.font = UIFont(name: messageFont, size: messageFontSize)
        }
    }

    var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    var messageColor: UIColor = .darkGray {
        didSet {
            messageLabel.textColor = messageColor
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.backgroundColor = .clear
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: Border = {
        let borderView = Border()
        return borderView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(bottomBorder)

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
