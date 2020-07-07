//
//  MessageFullView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class MessageFullView: UIView {

    let BOUNDS: CGFloat = 30

    let titleTextView: TextView = {
        let label = TextView()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        label.textColor = .black
        label.textContainer.maximumNumberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionTextView: TextView = {
        let label = TextView()
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.textColor = .darkGray
        label.textContainer.maximumNumberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textView: TextView = {
        let textView = TextView()
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textView.textColor = UIColor.darkGray
        textView.textContainer.maximumNumberOfLines = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = UIColor.MainColors.mainColor
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 2.5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        return button
    }()

    lazy var secondaryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 2.5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.MainColors.mainColor.cgColor
        button.setTitleColor(UIColor.MainColors.mainColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setup()
    }

    init(title: String,
         description: String,
         primaryColor: UIColor = UIColor.MainColors.mainColor,
         _ secondaryColor: UIColor = .white)
    {
        super.init(frame: CGRect.zero)
        self.titleTextView.text = title
        self.descriptionTextView.text = description
        self.primaryButton.backgroundColor = primaryColor
        self.secondaryButton.layer.borderColor = primaryColor.cgColor
        self.secondaryButton.setTitleColor(primaryColor, for: .normal)
        self.setup()
    }

    init(title: String,
         description: String,
         primaryButtonText: String,
         secondaryButtonText: String,
         primaryColor: UIColor = UIColor.MainColors.mainColor,
         _ secondaryColor: UIColor = .white)
    {
        super.init(frame: CGRect.zero)
        self.titleTextView.text = title
        self.descriptionTextView.text = description
        self.primaryButton.setTitle(primaryButtonText, for: .normal)
        self.secondaryButton.setTitle(secondaryButtonText, for: .normal)
        self.primaryButton.backgroundColor = primaryColor
        self.secondaryButton.layer.borderColor = primaryColor.cgColor
        self.secondaryButton.setTitleColor(primaryColor, for: .normal)
        self.setup()
    }

    func setup()
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.addSubview(self.titleTextView)
        self.addSubview(self.descriptionTextView)
        self.addSubview(self.textView)
        self.addSubview(self.primaryButton)
        self.addSubview(self.secondaryButton)

        self.titleTextView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        self.titleTextView.leftAnchor.constraint(equalTo: self.descriptionTextView.leftAnchor).isActive = true
        self.titleTextView.rightAnchor.constraint(equalTo: self.descriptionTextView.rightAnchor).isActive = true

        self.descriptionTextView.topAnchor.constraint(equalTo: self.titleTextView.bottomAnchor).isActive = true
        self.descriptionTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.BOUNDS).isActive = true
        self.descriptionTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.BOUNDS).isActive = true

        textView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10).isActive = true
        textView.widthAnchor.constraint(equalTo: descriptionTextView.widthAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        self.primaryButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
        self.primaryButton.leftAnchor.constraint(equalTo: self.descriptionTextView.leftAnchor).isActive = true

        self.secondaryButton.topAnchor.constraint(equalTo: self.primaryButton.bottomAnchor, constant: 20).isActive = true
        self.secondaryButton.leftAnchor.constraint(equalTo: self.descriptionTextView.leftAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
