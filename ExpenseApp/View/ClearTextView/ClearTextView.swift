//
//  ClearTextView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class ClearTextView: UITextView {

    var placeholder: String?

    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        toolbar.barStyle = UIBarStyle.default
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = UIColor.white
        toolbar.tintColor = UIColor.MainColors.lightColor
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    let toolbarSpace: UIBarButtonItem = {
        let barSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                       target: nil,
                                       action: nil)
        return barSpace
    }()

    lazy var toolbarDone: UIBarButtonItem = {
        let barDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                      target: nil,
                                      action: nil)
        barDone.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium",
                                                                            size: 16)!],
                                       for: .normal)
        return barDone
    }()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: textContainer)

        setup()
    }

    init(placeholder: String) {
        super.init(frame: CGRect.zero, textContainer: nil)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textColor = .lightGray
        tintColor = .gray
        layer.masksToBounds = true
        layer.cornerRadius = 2.5
        layer.borderWidth = 2
        layer.borderColor = UIColor.MainColors.lightGray.cgColor

        toolbar.items = [self.toolbarSpace, self.toolbarDone]

        inputAccessoryView = self.toolbar
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
