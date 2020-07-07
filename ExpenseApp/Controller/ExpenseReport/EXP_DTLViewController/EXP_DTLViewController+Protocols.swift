//
//  CreateExpenseController+Protocols.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/22/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import GooglePlaces

extension EXP_DTLViewController:
    LabeledTextFieldDelegate,
    LabeledLocationSelectViewDelegate,
    LabeledImagePickerViewDelegate,
    CheckboxViewDelegate,
    LabeledTimePickerViewDelegate,
    LabeledTableColumnRefPickerViewDelegate,
    LabeledActionViewDelegate,
GuestListTableViewControllerDelegate {

    func guestListTableViewController(_ controller: GuestListTableViewController, guestList: [EXP_DTL_GUESTS]) {
        self._guestList = guestList
    }

    func labeledActionView(_ view: LabeledActionView, onClick tag: Int) {
        if tag == 1 { // UserSearchTableView
            let controller = GuestListTableViewController()
            controller.models = self._guestList
            controller.expense = self._expense
            controller.trip = self.exp_hdr
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    /*
     2: Meal Type
     3: Meal Location
     4: Meal Allowance
     */
    func labeledTableColumnRefPickerViewDelegate(_ view: LabeledTableColumnRefPickerView, selected model: AAI_TABLE_COLUMN_REF, tag: Int) {
        print("TableColRefDelegate")
        switch tag {
        case 1: // Expense Type
            if let expenseType = model.COLUMN_VALUE {
                setExpenseView(expenseType: expenseType, animated: true)
            }
        case 2: // Meal Type
            break
        case 3: // Meal Location
            break
        case 4: // Meal Allowance
            break
        case 5: // Meal Misc Type
            break
        case 6: // Meal Misc Location
            break
        default: break
        }
    }


    func labeledTextField(_ view: LabeledTextField, valueChanged value: String, tag: Int) {
        switch tag {
        case 2: // odomStart
            setOdomEnd()
            break
        case 3: // odomEnd
            break
        default:
            break
        }
    }

    func dbManager(model: EXP_DTL?, response: URLResponse?, EXP_DTLRecordCreated error: Error?) {
        if let _ = error {
            return
        }
        /*
        if let expense = model,
            let expenseID = expense.EXP_ID,
            let expenseDetailID = expense.ID,
            let guests = addGuestsSelectView.users {
            DBManager.shared.saveExpenseGuests(expenseID: expenseID, expenseDetailID: expenseDetailID, guests: guests) { (guests, error, message) in
            }
        }*/
        createExpenseButton.isEnabled = true
        resetInputViews()
        scrollToTop()
    }

    func scrollToTop(animated: Bool = true) {
        scrollView.scrollToTop(true)
        topBorder.backgroundColor = .clear
    }

    func dbManager(models: [EXP_DTL]?, response: URLResponse?, getTripExpenses error: Error?) {

    }

    func labeledTimePicker(_ picker: LabeledTimePickerView, done date: Date, tag: Int) {
        
    }

    func labeledTimePicker(_ picker: LabeledTimePickerView, datePicked date: Date, tag: Int) {
        switch tag {
        case 1: // start time
            expEndDateTimePickerView.minDate = date
            break
        case 2: // end time
            expBegDateTimePickerView.maxDate = date
            break
        default:
            break
        }
    }

    func checkboxView(_ checkboxView: CheckboxView, checkboxTapped isChecked: Bool, tag: Int) {
        switch tag {
        case 1: // round trip flag
            setOdomEnd()
            break
        case 2: // per diem flag
            totalAmountNumberPad.display(!isChecked)
            tipsNumberPad.display(!isChecked)
            begLatLonSelectView.display(!isChecked)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            break
        default:
            break
        }
    }

    func setOdomEnd() {
        guard let origin = begLatLonSelectView.place,
            let destination = endLatLonLocationSelectView.place,
            let odomStartText = odoFromViewNumberPad.field.text,
            let odomStart = Double(odomStartText) else {
                return
        }
        DBManager.shared.getDistance(origin: origin.coordinate, destination: destination.coordinate) { (model, error, message) in
            guard let model = model else {
                return
            }

            guard let row = model.rows.first,
                let element = row.elements.first,
                let distance = element.distance else {
                    return
            }

            let miles = (distance.toMiles() * (self.roundTripCheckboxView.isChecked ? 2 : 1))
            let odomEnd = Int((odomStart + miles).rounded(.awayFromZero))
            self.odoToViewNumberPad.text = "\(odomEnd)"
        }
    }

    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, linkTapped imagePickerViewController: UIImagePickerController) {
        present(imagePickerViewController, animated: true, completion: nil)
    }

    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, canceled imagePickerViewController: UIImagePickerController) {
        imagePickerViewController.dismiss(animated: true, completion: nil)
    }

    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, imageSelected imagePickerViewController: UIImagePickerController, image: UIImage) {
        imagePickerViewController.dismiss(animated: true, completion: nil)
    }

    func labeledImagePickerView(_ labeledImagePickerView: LabeledImagePickerView, selectSourceType alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }

    func labeledUIDatePicker(_ textField: UIDatePicker, date: Date, tag: Int) {
    }

    func labeledLocationSelectView(_ labeledLocationSelectView: LabeledLocationSelectView, gmsAutocompleteViewController: GMSAutocompleteViewController, placeChosen place: GMSPlace, tag: Int) {
        switch tag {
        case 2:// Origin
            break
        case 3:// Destination
            setOdomEnd()
            break
        default:
            break
        }
        gmsAutocompleteViewController.dismiss(animated: true, completion: nil)
    }

    func dismiss(_ gmsAutocompleteViewController: GMSAutocompleteViewController) {
        gmsAutocompleteViewController.dismiss(animated: true, completion: nil)
    }

    func present(_ gmsAutocompleteViewController: GMSAutocompleteViewController, tag: Int) {
        self.present(gmsAutocompleteViewController, animated: true, completion: nil)
    }

    func didEndEditing(_ textField: UITextField, value: String, tag: Int) {
    }

    func displayExpenseFields(fields: [AAI_TABLE_COLUMN_REF]) {

    }
}
