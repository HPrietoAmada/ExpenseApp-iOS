//
//  HoursPicker.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/12/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class HoursPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var minutes = [Int]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.getName(minutes: self.minutes[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected: \(self.minutes[row])")
    }
    
    func addSelection(selection: Int) {
        self.minutes.append(selection)
        self.reloadAllComponents()
    }
    
    func setComponents(components: [Int]) {
        self.minutes.removeAll()
        self.minutes = components
        self.reloadAllComponents()
    }
    
    func getName(minutes: Int) -> String {
        let hours = minutes / 60
        if minutes < 60 {
            return "\(minutes) minutes"
        }
        return "\(hours) hours"
    }
    
    init(_ minutes: [Int]) {
        super.init(frame: CGRect.zero)
        self.minutes = minutes
        self.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        self.delegate = self
        self.dataSource = self
    }
}
