//
//  LabeledTableColumnRefPickerView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/21/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol LabeledTableColumnRefPickerViewDelegate {
    func labeledTableColumnRefPickerViewDelegate(_ view: LabeledTableColumnRefPickerView, selected model: AAI_TABLE_COLUMN_REF, tag: Int)
}

class LabeledTableColumnRefPickerView: UIView {
    var models: [AAI_TABLE_COLUMN_REF] = [] {
        didSet {
            picker.reloadAllComponents()
        }
    }

    var _selectionRequired: Bool = true {
        didSet {

        }
    }

    var _value: AAI_TABLE_COLUMN_REF? {
        didSet {
            guard let value = _value else { return }

            if let description = value.DESCRIPTION {
                _description = description
            }

            if let valueIndex = self.models.firstIndex(where: { $0.COLUMN_VALUE == value.COLUMN_VALUE }) {
                if valueIndex != picker.selectedRow(inComponent: 0) {
                    picker.selectRow(valueIndex, inComponent: 0, animated: false)
                }
            }
        }
    }

    var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledTableColumnRefPickerViewDelegate?

    var height: CGFloat = 100

    var disabled: Bool = false {
        didSet {
            isUserInteractionEnabled = false
        }
    }

    var _description: String = "" {
        didSet {
            field.text = _description
        }
    }

    var _title: String = "" {
        didSet {
            label.text = _title
        }
    }

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
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.tintColor = .white
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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

    lazy var toolbarSpaceButton: UIBarButtonItem = {
        let barSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        return barSpace
    }()

    lazy var toolbarDoneButton: UIBarButtonItem = {
        let barDone = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.done,
            target: self,
            action: #selector(handleDone)
        )
        barDone.setTitleTextAttributes(
            [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 16)!],
            for: .normal
        )
        return barDone
    }()

    @objc func handleDone() {
        endEditing(true)
    }

    let bottomBorder: Border = {
        return Border()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
        self.initPicker()
        self.models = []
        self.label.text = ""
    }

    init(text: String,
         models: [PickerViewModel],
         tag: Int = 0) {
        super.init(frame: CGRect.zero)
        self.label.text = text
        self.initializeView()
        self.initPicker()
        self.picker.reloadAllComponents()
        self.tag = tag
    }

    init(_ text: String,
         placeholder: String = "",
         tag: Int = 0) {
        super.init(frame: CGRect.zero)
        self.initializeView()
        self.initPicker()
        self.field.placeholder = placeholder
        self.label.text = text
        self.tag = tag
    }

    private func initializeView() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(field)
        addSubview(bottomBorder)

        toolbar.items = [toolbarSpaceButton, toolbarDoneButton]
        field.inputAccessoryView = self.toolbar
        field.inputView = picker

        // Field Constraints
        field.delegate = self
        field.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // Bottom Border Constraints
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(becomeResponder))
        addGestureRecognizer(tapGesture)

        heightLayoutConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true
        display()
    }

    func reset() {
        _value = nil
        field.text = self._description
    }

    func setToFirst() {
        guard let _ = models.first else { return }
        
    }

    @objc func becomeResponder() {
        field.becomeFirstResponder()
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func setHeight(height: CGFloat) {
        heightLayoutConstraint?.constant = height
        heightLayoutConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
