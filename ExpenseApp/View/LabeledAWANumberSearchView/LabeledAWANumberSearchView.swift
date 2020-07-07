//
//  LabeledAWANumberSearchView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/14/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit


protocol LabeledAWANumberSearchViewDelegate {
    func labeledAWANumberSearchViewDelegate(_ view: LabeledAWANumberSearchView, present controller: NavigationController, tag: Int)
    func labeledAWANumberSearchViewDelegate(_ view: LabeledAWANumberSearchView, controller: NavigationController, selected awa: WEB_VIA2_PR_HDR, tag: Int)
}

class LabeledAWANumberSearchView: UIView/*, AWASearchTableViewControllerDelegate */{
    /*
    func awaSearchTableViewControllerDelegate(_ controller: NavigationController, awa: WEB_VIA2_PR_HDR, done error: Error?) {
        if let error = error {
            print("Awa Error: \(error.localizedDescription)")
            return
        }
        model = awa
        guard let delegate = delegate else {
            return
        }

        delegate.labeledAWANumberSearchViewDelegate(self, controller: controller, selected: awa, tag: tag)
    }
    */

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledAWANumberSearchViewDelegate?

    var height: CGFloat = 100

    var model: WEB_VIA2_PR_HDR? {
        didSet {
            guard let awa = model else {
                usersLabel.textColor = .placeholder
                usersLabel.text = placeholder
                text = "Attach an AWA"
                return
            }
            if let awa = awa.AWA_NUMBER {
                text = awa
            } else {
                if let purpose = awa.PURPOSE {
                    text = purpose
                } else {
                    text = "AWA selected"
                }
            }
        }
    }

    var placeholder: String = "" {
        didSet {
            usersLabel.textColor = .placeholder
            usersLabel.text = placeholder
        }
    }

    var text: String = "" {
        didSet {
            usersLabel.textColor = .black
            usersLabel.text = text
        }
    }

    /* View Components */
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let usersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .placeholder
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @objc func tap() {
        /*
        guard let delegate = delegate else {
            return
        }
        let controller = AWASearchTableViewController()
        controller.delegate = self
        let navController = NavigationController(rootViewController: controller)
        delegate.labeledAWANumberSearchViewDelegate(self, present: navController, tag: tag)
        */
    }

    let toolBarLeftSpace: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        return barButton
    }()

    let toolBarDone: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil)
        barButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 16)!], for: .normal)
        return barButton
    }()

    let toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        toolbar.barStyle = UIBarStyle.default
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = UIColor.white
        toolbar.tintColor = UIColor.MainColors.lightColor
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    let bottomBorder: Border = {
        return Border()
    }()

    init(_ label: String, tag:Int, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.placeholder = placeholder
        self.usersLabel.text = placeholder
        self.tag = tag
        self.setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        addSubview(label)
        addSubview(usersLabel)
        addSubview(bottomBorder)

        // Field Constraints
        usersLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        usersLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        usersLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        usersLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.addGestureRecognizer(tapGesture)

        self.display()
    }

    func reset() {
        model = nil
        usersLabel.textColor = .placeholder
        usersLabel.text = placeholder
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


