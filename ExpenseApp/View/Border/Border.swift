//
//  BorderView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/21/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

public class Border: UIView {

    var borderHeight: CGFloat = 0.75 {
        didSet {
            heightLayoutConstraint?.constant = borderHeight
        }
    }

    var borderColor: UIColor = ._lightGray {
        didSet {
            backgroundColor = ._lightGray
        }
    }

    fileprivate var heightLayoutConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ._lightGray
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: 0.75)
        heightLayoutConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
