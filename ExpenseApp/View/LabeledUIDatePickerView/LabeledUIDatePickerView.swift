//
//  LabeledUIDatePickerView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol LabeledUIDatePickerViewDelegate {
    func labeledUIDatePicker(_ textField: UIDatePicker, date: Date, tag: Int)
}

class LabeledUIDatePickerView: UIView {
    var value: Int?

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledTextFieldDelegate?

    var height: CGFloat = 100

    var minDate: Date? {
        didSet {
            datePicker.minimumDate = minDate
        }
    }

    var maxDate: Date? {
        didSet {
            datePicker.maximumDate = maxDate
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

    let field: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue", size: 18)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .white
        datePicker.backgroundColor = .white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

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
        self.field.placeholder = placeholder
        self.inputView?.tag = tag
        self.initialzeViews()
    }

    @objc func recognizeTap() {
        if !self.field.isFirstResponder {
            self.field.becomeFirstResponder()
        }
    }

    func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        self.addSubview(self.label)
        self.addSubview(self.field)
        self.addSubview(self.bottomBorder)

        self.toolBar.items = [self.toolBarLeftSpace,self.toolBarDone]
        self.field.inputAccessoryView = self.toolBar

        toolBarDone.action = #selector(handleDone)

        field.inputView = datePicker

        // Field Constraints
        field.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recognizeTap))
        self.addGestureRecognizer(tapGesture)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func reset() {
        field.text = ""
    }

    @objc func dateChanged() {
        field.text = datePicker.date.getFormattedDate()
    }

    @objc func handleDone() {
        endEditing(true)
        delegate?.didEndEditing(field, value: field.text!, tag: tag)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        delegate?.didEndEditing(textField, value: field.text!, tag: tag)
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
