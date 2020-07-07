//
//  LabeledActionView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/14/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

protocol LabeledActionViewDelegate {
    func labeledActionView(_ view: LabeledActionView, onClick tag: Int)
}

class LabeledActionView: UIView {

    var _stringValue: String = ""
    var _intValue: Int = 0

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledActionViewDelegate?

    var placeholder: String = ""

    var display: Bool = true {
        didSet {
            alpha = display ? 1 : 0
            heightLayoutConstraint?.constant = display ? _height : 0
        }
    }

    var _height: CGFloat = 100 {
        didSet {
            guard let heightConstraint = heightLayoutConstraint else { return }
            heightConstraint.constant = _height
        }
    }

    var _title: String = "" {
        didSet {
            titleLabel.text = _title
        }
    }

    var _description: String = "" {
        didSet {
            if _description.underestimatedCount == 0 {
                actionButton.setTitleColor(UIColor.placeholder, for: .normal)
                actionButton.setTitle(placeholder, for: .normal)
            } else {
                actionButton.setTitleColor(UIColor.black, for: .normal)
                actionButton.setTitle(_description, for: .normal)
            }
        }
    }

    /* View Components */
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 18)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.placeholder, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonClicked), for: .touchUpInside)
        return button
    }()

    let bottomBorder: Border = {
        return Border()
    }()

    init(_ label: String, tag: Int, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.titleLabel.text = label
        self.actionButton.setTitle(placeholder, for: .normal)
        self.tag = tag
        self.placeholder = placeholder
        self.initialzeViews()
    }

    fileprivate func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        addSubview(self.titleLabel)
        addSubview(self.actionButton)
        addSubview(self.bottomBorder)

        // button Constraints
        actionButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // button.delegate = self

        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        // Label Constraints
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
    }

    @objc func handleButtonClicked() {
        guard let delegate = delegate else {
            return
        }
        delegate.labeledActionView(self, onClick: self.tag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
