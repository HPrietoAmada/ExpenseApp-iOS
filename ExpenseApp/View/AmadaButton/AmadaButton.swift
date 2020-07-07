//
//  AmadaButton.swift
//  AmadaTimeOff
//
//  Created by IT Support on 5/29/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol AmadaButtonDelegate {
    func amadaButton(_ amadaButton: AmadaButton, buttonClicked tag: Int)
}

class AmadaButton: UIButton {

    var activeColor: UIColor?

    var delegate: AmadaButtonDelegate?

    fileprivate var heightLayoutConstraint: NSLayoutConstraint?
    fileprivate var widthLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 40 {
        didSet {
            guard let heightLayoutConstraint = heightLayoutConstraint else {
                return
            }

            let buttonIsHidden = heightLayoutConstraint.constant == 0

            heightLayoutConstraint.constant = buttonIsHidden ? 0 : height
        }
    }

    var buttonEnabled: Bool = true {
        didSet {
            isEnabled = buttonEnabled
            backgroundColor = buttonEnabled ? buttonColor : inactiveButtonColor
        }
    }

    var inactiveButtonColor: UIColor = UIColor.lightGray

    var width: CGFloat = 60 {
        didSet {
            guard let widthLayoutConstraint = widthLayoutConstraint else {
                return
            }

            widthLayoutConstraint.constant = width
        }
    }

    var fontSize: CGFloat = 16 {
        didSet {
            titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        }
    }

    var title: String = "Button" {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    var titleColor: UIColor = UIColor.white {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }

    var borderColor: UIColor = UIColor.MainColors.mainColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    var buttonColor: UIColor = UIColor.MainColors.mainColor {
        didSet {
            backgroundColor = buttonColor
        }
    }

    var fontType: String = "HelveticaNeue-Bold" {
        didSet {
            titleLabel?.font = UIFont(name: fontType, size: fontSize)
        }
    }

    init(_ backgroundImage: UIImage,
         title: String = "") {
        super.init(frame: CGRect.zero)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.title = title
        setTitle(title, for: .normal)
        self.activeColor = backgroundColor
        self.initialize()
    }

    init(_ title: String) {
        super.init(frame: CGRect.zero)
        self.title = title
        setTitle(title, for: .normal)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initialize()
        self.activeColor = UIColor.black
    }

    func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3
        self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        backgroundColor = buttonColor
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        widthLayoutConstraint = widthAnchor.constraint(equalToConstant: width)
        widthLayoutConstraint?.isActive = true

        display()
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func activate(_ active: Bool = true) {
        self.backgroundColor = active ? self.activeColor : UIColor.lightGray
        self.isEnabled = active
    }

    @objc func buttonClicked() {
        guard let delegate = delegate else {
            return
        }

        delegate.amadaButton(self, buttonClicked: tag)
    }

    func setState(_ title: String, active: Bool = false) {
        setTitle(title, for: .normal)
        setTitleColor(active ? UIColor.MainColors.lightColor : UIColor.white, for: .normal)
        backgroundColor = active ? UIColor.white : UIColor.MainColors.green
        layer.borderColor = active ? UIColor.MainColors.lightColor.cgColor : UIColor.MainColors.green.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
