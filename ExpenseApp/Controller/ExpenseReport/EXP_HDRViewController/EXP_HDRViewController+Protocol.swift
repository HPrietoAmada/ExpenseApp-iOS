//
//  TripCreateViewController+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/19/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_HDRViewController:
    LabeledTextFieldDelegate,
    LabeledTimePickerViewDelegate,
    LabeledActionViewDelegate,
    TextInputViewControllerDelegate
/*,LabeledAWANumberSearchViewDelegate*/ {
    func textInputViewController(_ controller: TextInputViewController, primaryButtonClicked message: String, tag: Int) {
        if tag == 1 { // Notes TextInput Controller
            notesTextInputView._stringValue = message
            notesTextInputView._description = message
            controller.navigationController?.popViewController(animated: true)
        }
    }

    func textInputViewController(_ controller: TextInputViewController, secondaryButtonClicked message: String, tag: Int) {

    }


    func labeledActionView(_ view: LabeledActionView, onClick tag: Int) {
        switch tag {
        case 1: // Notes
            if let exp_hdr = trip {
                let controller = MessageViewController()
                controller.trip = exp_hdr
                controller.tag = tag
                navigationController?.pushViewController(controller, animated: true)
            } else {
                let controller = TextInputViewController()
                controller._title = "Trip Notes"
                controller._description = "What would you like your manager or accounting to know?"
                controller._primary = "Add"
                controller._secondary = "Cancel"
                controller.delegate = self
                controller.tag = tag
                navigationController?.pushViewController(controller, animated: true)
            }
        default:
            break
        }
    }

    /*
    func labeledAWANumberSearchViewDelegate(_ view: LabeledAWANumberSearchView, present controller: NavigationController, tag: Int) {
        present(controller, animated: true, completion: nil)
    }

    func labeledAWANumberSearchViewDelegate(_ view: LabeledAWANumberSearchView, controller: NavigationController, selected awa: WEB_VIA2_PR_HDR, tag: Int) {
        controller.dismiss(animated: true, completion: nil)
    }
     */


    func labeledTextField(_ view: LabeledTextField, valueChanged value: String, tag: Int) {
        
    }

    func labeledTimePicker(_ picker: LabeledTimePickerView, done date: Date, tag: Int) {

    }

    func labeledTimePicker(_ picker: LabeledTimePickerView, datePicked date: Date, tag: Int) {
        switch tag {
        case 1: // start time picker
            tripEndTimeView.minDate = date
            break
        case 2: // end time picker
            break
        default:
            break
        }
    }

    func didEndEditing(_ textField: UITextField, value: String, tag: Int) {
    }
}
