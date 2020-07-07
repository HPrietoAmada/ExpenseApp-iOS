//
//  LabeledTimePickerView+TextField.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LabeledTimePickerView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        field.text = datePicker.date.getFormattedDate(format: dateFormat)
    }
}
