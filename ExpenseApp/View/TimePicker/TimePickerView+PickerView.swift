//
//  TimePickerView+PickerView.swift
//  AmadaTimeOff
//
//  Created by IT Support on 5/23/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension TimePickerView: UIPickerViewDelegate, UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.setTimePickerComponents(component: component)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.setTimePickerComponentTitles(component: component, row: row)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.setTimePickerSelection(row: row, component: component)
        self.field.text = self.getTimeString()

        guard let delegate = delegate else { return }

        let hour = hours[pickerView.selectedRow(inComponent: 0)]
        let minute = minutes[pickerView.selectedRow(inComponent: 1)]
        let pm = dayTimes[pickerView.selectedRow(inComponent: 2)] == "PM"
        delegate.didSelectTime(pickerView, row: row, inComponent: component, hour: hour, minute: minute, pm: pm, tag: tag)
    }

    func willChangeValue<Value>(for keyPath: KeyPath<TimePickerView, Value>) {
        print("Will Change Value")
    }
}
