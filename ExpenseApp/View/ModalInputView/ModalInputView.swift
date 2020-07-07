//
//  OdometerInputView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 6/4/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ModalInputView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 21)
        textField.placeholder = "Placeholder (optional)"
        textField.setLeftPadding(15)
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 1
        button.setTitle("Primary", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.titleLabel?.textColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let secondaryButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.white
        button.setTitle("Secondary", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    init(title: String) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    init(title: String, placeholder: String, primaryButtonTitle: String, secondaryButtonTitle: String) {
        super.init(frame: CGRect.zero)
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        self.primaryButton.setTitle(primaryButtonTitle, for: .normal)
        self.secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
        self.initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeView() {
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2.5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(titleLabel)
        self.addSubview(textField)
        self.addSubview(primaryButton)
        self.addSubview(secondaryButton)

        let bounds:CGFloat = 25

        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -bounds).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: bounds).isActive = true

        self.textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        self.textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -bounds).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: bounds).isActive = true
        self.textField.heightAnchor.constraint(equalToConstant: 35).isActive = true

        self.primaryButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 10).isActive = true
        self.primaryButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -bounds).isActive = true
        self.primaryButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: bounds).isActive = true
        self.primaryButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        self.secondaryButton.topAnchor.constraint(equalTo: self.primaryButton.bottomAnchor, constant: 10).isActive = true
        self.secondaryButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -bounds).isActive = true
        self.secondaryButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: bounds).isActive = true
        self.secondaryButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        self.bottomAnchor.constraint(equalTo: self.secondaryButton.bottomAnchor, constant: 20).isActive = true

    }
}
