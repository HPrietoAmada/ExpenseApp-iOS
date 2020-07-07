//
//  DatePickerView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/23/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: DatePickerViewDelegate?

    var dateFormat: String?

    var placeholder: String?

    var height: CGFloat = 100

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
        textField.textAlignment = .left
        textField.textColor = UIColor.MainColors.darkGray
        textField.tintColor = UIColor.black
        textField.backgroundColor = UIColor.clear
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 0,
                                                  height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = .white
        datePicker.backgroundColor = .white
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let toolBarLeftSpace: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                        target: nil,
                                        action: nil)
        return barButton
    }()

    let toolBarDone: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                                        target: nil,
                                        action: nil)
        barButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium",
                                                                             size: 16)!],
                                         for: .normal)
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

    init(_ label: String,
         placeholder: String = "0:00 AM",
         dateFormat: String = "hh:mm a") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        placeholderLabel.text = placeholder
        self.dateFormat = dateFormat
        self.placeholder = placeholder
        setup()
    }

    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        addSubview(label)
        addSubview(placeholderLabel)
        addSubview(field)
        addSubview(bottomBorder)

        toolBar.items = [toolBarLeftSpace, toolBarDone]
        field.inputAccessoryView = toolBar
        field.inputView = datePicker

        // Field Constraints
        field.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.75).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        placeholderLabel.rightAnchor.constraint(equalTo: field.rightAnchor).isActive = true
        placeholderLabel.leftAnchor.constraint(equalTo: field.leftAnchor).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: field.topAnchor).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: field.bottomAnchor).isActive = true

        // Picker data/delegate handler
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        self.addGestureRecognizer(tapGesture)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func setDate(date: Date) {
        datePicker.date = date
        placeholderLabel.textColor = .black
        if let dateFormat = dateFormat {
            placeholderLabel.text = getTimeString(dateFormat)
        } else {
            placeholderLabel.text = getTimeString()
        }
    }

    func getTimeString(_ format: String = "hh:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: datePicker.date)
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    @objc func handleViewTapped() {
        if !self.datePicker.isFirstResponder {
            self.datePicker.becomeFirstResponder()
        }

    }

    func reset() {
        label.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
