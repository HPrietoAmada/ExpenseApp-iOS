//
//  LabeledPickerField.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol TimePickerViewDelegate {
    func didSelectTime(_ pickerView: UIPickerView, row: Int, inComponent component: Int, hour: Int, minute: Int, pm: Bool, tag: Int)
}

class TimePickerView: UIView {

    var delegate: TimePickerViewDelegate?

    var hour: Int = 1
    var minute: Int = 0
    var pm: Bool = true

    /* Picker Components */
    var dayTimes = ["PM","AM"]
    var hours = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var minutes = [Int]()

    private var heightLayoutConstraint: NSLayoutConstraint?

    /* View Components */
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let field: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        textField.textAlignment = .right
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
        picker.tintColor = UIColor.white
        picker.backgroundColor = UIColor.white
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(_ label:String,
         tag:Int,
         placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.picker.tag = tag
        self.field.placeholder = placeholder
        self.initialzeViews()
    }

    func setTimePickerComponentTitles(component: Int, row: Int) -> String {
        switch (component) {
        case 0:
            return "\(self.hours[row])"
        case 1:
            return String(format: "%02d", self.minutes[row])
        case 2:
            return "\(self.dayTimes[row])"
        default:
            return ""
        }
    }

    @objc func recognizeTap() {
        if !self.picker.isFirstResponder {
            self.picker.becomeFirstResponder()
        }
    }

    private func initialzeViews() {
        // Add Components to View
        self.addSubview(self.label)
        self.addSubview(self.field)
        self.addSubview(self.bottomBorder)
        
        self.toolBar.items = [self.toolBarLeftSpace, self.toolBarDone]
        self.field.inputAccessoryView = self.toolBar
        self.field.inputView = self.picker

        // Field Constraints
        self.field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.field.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.field.widthAnchor.constraint(equalToConstant: 80).isActive = true

        // Bottom Border Constraints
//        self.bottomBorder.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
//        self.bottomBorder.topAnchor.constraint(equalTo: self.field.bottomAnchor).isActive = true
//        self.bottomBorder.rightAnchor.constraint(equalTo: self.field.rightAnchor).isActive = true
//        self.bottomBorder.widthAnchor.constraint(equalTo: self.field.widthAnchor).isActive = true
        self.bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomBorder.heightAnchor.constraint(equalToConstant: 0.75).isActive = true

        // Label Constraints
        self.label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.field.leftAnchor, constant: -10).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.field.bottomAnchor).isActive = true

        // Picker data/delegate handler
        self.picker.delegate = self
        self.picker.dataSource = self

        // Sets minutes for pickerView
        self.loadMinutes()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTapped))
        self.addGestureRecognizer(tapGesture)

        heightLayoutConstraint = self.heightAnchor.constraint(equalToConstant: 50)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? 50 : 0
    }

    @objc func handleViewTapped() {
        if !self.picker.isFirstResponder {
            self.picker.becomeFirstResponder()
        }
    }

    func getTimeString() -> String {
        return "\(self.hour):\(String(format: "%02d", self.minute)) \(self.pm ? "PM" : "AM")"
    }

    // Sets the number of rows per component in picker
    func setTimePickerComponents(component: Int) -> Int {
        switch (component) {
        case 0:
            return self.hours.count
        case 1:
            return self.minutes.count
        case 2:
            return self.dayTimes.count
        default:
            return 0
        }
    }

    // Sets the raw value in pickerView property
    func setTimePickerSelection(row: Int, component: Int) {
        switch (component) {
        case 0: // hour
            self.hour = self.hours[row]
            break
        case 1: // minute
            self.minute = self.minutes[row]
            break
        case 2: // pm
            self.pm = self.dayTimes[row] == "PM"
            break
        default:
            break
        }
    }

    /* Compares the times of self and another timePickerView, set self's properties equal to timePicker passed in params */
    func copyFromTimePickerSelection(timePicker: TimePickerView) {
        for index in 0...timePicker.picker.numberOfComponents-1 {
            self.picker.selectRow(timePicker.picker.selectedRow(inComponent: index), inComponent: index, animated: false)
        }
        self.picker.reloadAllComponents()
    }

    /* Compares the times of self and another timePickerView, returns the hour and minute difference */
    func getTimeDifferenceBetweenTimePickers(timePickerView: TimePickerView) -> (hours: Int, minutes: Int) {
        let timeDiff: Int = self.pm == timePickerView.pm ? 0 : 12
        let hourDiff: Int = timePickerView.hour - self.hour
        let minDiff: Int = timePickerView.minute - self.minute

        let hours = (minDiff < 0) ? (timeDiff + hourDiff - 1) : (timeDiff + hourDiff)
        let minutes = (hours < 0) ? 0 : (minDiff < 0) ? (60 + minDiff) : minDiff
        return (hours < 0 ? 0 : hours, minutes)
    }

    func timeIsBefore(timePickerView: TimePickerView) -> Bool {
        // Same hour, previous minute selected
        if self.hour == timePickerView.hour
            && self.pm == timePickerView.pm
            && self.minute > timePickerView.minute {
            return false
        }

        // Previous hour selected
        if self.hour > timePickerView.hour
            && self.pm == timePickerView.pm {
            return false
        }

        return true
    }

    private func loadMinutes() {
        for index in 0...11 {
            self.minutes.append(index * 5)
        }
    }

    func validTimeSelected() -> Bool {
        if self.hour < 1 {
            return false
        }

        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
