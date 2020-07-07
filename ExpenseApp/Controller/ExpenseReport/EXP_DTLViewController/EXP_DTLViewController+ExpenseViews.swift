//
//  CreateExpenseController+ExpenseViews.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/13/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

/*
 Expense Types:
    - Hotel
    - Meals
    - Travel Fares
    - Tips
    - Taxi/Auto Rental
    - Trips
    - Telephone
    - Internet
    - Fax
    - Baggage
    - Parking
    - Overnight Incentives
    - Mileage
    - Troll
    - Gas on Rentals
    - Meeting
 */

extension EXP_DTLViewController {

    func setExpenseView(expenseType: String, animated: Bool) {
        noExpense(false)

        var viewHeight: CGFloat = 450
        
        let expenseFields = _tableColRef
            .filter({
                $0.COLUMN_NAME == "EXP_TYPE_FIELD" && $0.ATTRIBUTE1 == expenseType
            })

        expenseFields.forEach { (expenseField) in
            switch expenseField.COLUMN_VALUE {
            case "*ADD_GUESTS":
                guestSelectView.display = true
                viewHeight = viewHeight + 100
                break
            case "*ATTACH_RECEIPTS":
                attachReceiptsImagePickerView.display()
                viewHeight = viewHeight + 100
                break
            case "BEG_LAT_LON":
                begLatLonSelectView.display()
                if let description = expenseField.DESCRIPTION {
                    begLatLonSelectView.title = description
                }
                viewHeight = viewHeight + 100
                break
            case "CURRENCY":
                currencyTypePicker.display()
                if let description = expenseField.DESCRIPTION {
                    currencyTypePicker.title = description
                }
                viewHeight = viewHeight + 100
                break
            case "END_LAT_LON":
                endLatLonLocationSelectView.display()
                if let description = expenseField.DESCRIPTION {
                    endLatLonLocationSelectView.title = description
                }
                viewHeight = viewHeight + 100
                break
            case "EXP_BEG_DATE":
                if let description = expenseField.DESCRIPTION {
                    expBegDateTimePickerView.title = description
                }
                expBegDateTimePickerView.display()
                viewHeight = viewHeight + 100
                break
            case "EXP_END_DATE":
                if let description = expenseField.DESCRIPTION {
                    expEndDateTimePickerView.title = description
                }
                expEndDateTimePickerView.display()
                viewHeight = viewHeight + 100
                break
            case "MEAL_TYPE":
                mealLocationPicker.display()
                viewHeight = viewHeight + 100
                break
            case "MEAL_LOCATION":
                mealLocationPicker.display()
                viewHeight += 100
                break
            case "NET_AMOUNT":
                if let description = expenseField.DESCRIPTION {
                    totalAmountNumberPad.title = description
                }
                totalAmountNumberPad.display()
                viewHeight = viewHeight + 100
                break
            case "NOTES":
                if let description = expenseField.DESCRIPTION {
                    notesInputView.title = description
                }
                notesInputView.display()
                viewHeight = viewHeight + 200
                break
            case "ODO_FROM":
                if let description = expenseField.DESCRIPTION {
                    odoFromViewNumberPad.title = description
                }
                odoFromViewNumberPad.display()
                viewHeight = viewHeight + 100
                break
            case "ODO_TO":
                if let description = expenseField.DESCRIPTION {
                    odoToViewNumberPad.title = description
                }
                odoToViewNumberPad.display()
                viewHeight = viewHeight + 100
                break
            case "ODO_UOM":
                if let description = expenseField.DESCRIPTION {
                    odoUOMPicker._title = description
                }
                odoUOMPicker.display()
                viewHeight = viewHeight + 100
                break
            case "PER_DIEM_FLAG":
                if let description = expenseField.DESCRIPTION {
                    perDiemCheckboxView.title = description
                }
                perDiemCheckboxView.display()
                viewHeight = viewHeight + 100
                break
            case "ROUND_TRIP_FLAG":
                if let description = expenseField.DESCRIPTION {
                    roundTripCheckboxView.title = description
                }
                roundTripCheckboxView.display()
                viewHeight = viewHeight + 100
                break
            case "TIPS_AMOUNT":
                if let description = expenseField.DESCRIPTION {
                    tipsNumberPad.title = description
                }
                tipsNumberPad.display()
                viewHeight = viewHeight + 100
                break
            case "MISC_MEAL_TYPE":
                mealMiscTypePicker.display()
                mealMiscLocationPicker.display()
                viewHeight += 200
            default: break
            }
        }
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: viewHeight)

        if !animated { return }

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }


    // MARK : Different view parameters for all Expense Types

    func noExpense(_ animated: Bool = true) {
        expBegDateTimePickerView.display(false)
        expEndDateTimePickerView.display(false)
        begLatLonSelectView.display(false)
        endLatLonLocationSelectView.display(false)
        perDiemCheckboxView.display(false)
        mealTypePicker.display(false)
        mealLocationPicker.display(false)
        mealAllowancePicker.display(false)
        mealMiscTypePicker.display(false)
        mealMiscLocationPicker.display(false)
        currencyTypePicker.display(false)
        odoUOMPicker.display(false)
        odoFromViewNumberPad.display(false)
        odoToViewNumberPad.display(false)
        roundTripCheckboxView.display(false)
        totalAmountNumberPad.display(false)
        tipsNumberPad.display(false)
        notesInputView.display(false)
        guestSelectView.display = false
        attachReceiptsImagePickerView.display(false)
        // receiptImagePickerView.display(false)
        
        self.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: 490)
    }
}
