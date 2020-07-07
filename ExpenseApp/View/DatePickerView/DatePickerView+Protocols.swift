//
//  DatePickerView+Protocols.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/23/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func didSelectDate(_ datePicker: DatePickerView, date: Date, tag: Int)
}

extension DatePickerView {

    @objc func dateChanged(_ sender: UIDatePicker) {
        guard let delegate = delegate else {
            return
        }
        if let dateFormat = dateFormat {
            placeholderLabel.text = getTimeString(dateFormat)
        } else {
            placeholderLabel.text = getTimeString()
        }
        placeholderLabel.textColor = .black
        delegate.didSelectDate(self, date: sender.date, tag: tag)
    }
}
