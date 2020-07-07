//
//  TextView.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/9/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

public class TextView: UITextView {

    var padding: UIEdgeInsets = UIEdgeInsets(top: 7.5, left: 0, bottom: 7.5, right: 0) {
        didSet {
            textContainerInset = padding
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isUserInteractionEnabled = false
        isScrollEnabled = false
        isEditable = false
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        textContainerInset = padding
        textColor = ._black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
