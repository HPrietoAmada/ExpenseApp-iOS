//
//  TextInputView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 7/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class TextInputView: UIView {

    var placeholder: String?

    private var heightLayoutConstraint: NSLayoutConstraint?
    private var heightConstraint: CGFloat?

    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textView.tintColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

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
        let barSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                       target: nil,
                                       action: nil)
        return barSpace
    }()

    let toolbarDone: UIBarButtonItem = {
        let barDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                                      target: nil,
                                      action: nil)
        barDone.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium",
                                                                           size: 16)!],
                                       for: .normal)
        return barDone
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
    }

    init(_ placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.placeholder = placeholder
        self.textView.text = placeholder
        self.textView.textColor = .lightGray
        self.initializeView()
    }

    func initializeView() {
        layer.masksToBounds = true
        layer.borderColor = UIColor.MainColors.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        addSubview(textView)
        // self.addSubview(self.topBorder)

        translatesAutoresizingMaskIntoConstraints = false

        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        toolbar.items = [self.toolbarSpace, self.toolbarDone]

        textView.inputAccessoryView = self.toolbar

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: 60)
        heightLayoutConstraint?.isActive = true

        display()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        addGestureRecognizer(tapGesture)

        initTextView()
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0

        if let height = heightConstraint {
            heightLayoutConstraint?.constant = display ? height : 0
            return
        }
        heightLayoutConstraint?.constant = display ? 60 : 0
    }

    func setHeight(height: CGFloat)
    {
        heightLayoutConstraint?.constant = height
        heightConstraint = height
    }

    @objc func handleTap()
    {
        self.textView.becomeFirstResponder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
