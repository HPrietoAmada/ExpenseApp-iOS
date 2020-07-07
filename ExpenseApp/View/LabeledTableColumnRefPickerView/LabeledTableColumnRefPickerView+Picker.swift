//
//  LabeledTableColumnRefPickerView+Picker.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/21/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LabeledTableColumnRefPickerView: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return models.count
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 250
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedModel = self.models[row]
        _value = selectedModel
        guard let delegate = delegate else { return }
        let pickerViewModel = models[row]
        delegate.labeledTableColumnRefPickerViewDelegate(self, selected: pickerViewModel, tag: tag)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return models[row].DESCRIPTION ?? ""
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let value = _value else {
            return
        }
        self._value = value
    }

    func initPicker() {
        self.picker.delegate = self
        self.picker.dataSource = self
    }
}
