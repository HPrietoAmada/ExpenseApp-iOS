//
//  CreateExpenseController+Validation.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/24/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreData

extension EXP_DTLViewController {

    func handleExpenseChosen() {

    }

    func validateExpense() {

    }

    /*

     scrollView.addSubview(startDatePicker)
     scrollView.addSubview(endDatePicker)
     scrollView.addSubview(startTimeDatePicker)
     scrollView.addSubview(endTimeDatePicker)
     scrollView.addSubview(odomStartViewNumberPad)
     scrollView.addSubview(odomEndViewNumberPad)
     scrollView.addSubview(mealTypePicker)
     scrollView.addSubview(numberOfPeopleNumberPad)
     scrollView.addSubview(amountPaidNumberPad)
     scrollView.addSubview(tipNumberPad)
     scrollView.addSubview(purposeMessageInputView)
     scrollView.addSubview(createExpenseButton)
     scrollView.addSubview(labeledLocationSelectView)
     scrollView.addSubview(labeledDestinationSelectView)
     scrollView.addSubview(labeledOriginSelectView)
     scrollView.addSubview(receiptImagePickerView)

     */
    func resetInputViews() {
        if let exp_hdr = exp_hdr,
            let start_date_str = exp_hdr.BEG_DATE,
            let start_date = start_date_str.toDateTime(),
            let end_date_str = exp_hdr.END_DATE,
            let end_date = end_date_str.toDateTime() {
            expBegDateTimePickerView.minDate = start_date
            expBegDateTimePickerView.maxDate = end_date
            expEndDateTimePickerView.minDate = start_date
            expEndDateTimePickerView.maxDate = end_date
        }
        expBegDateTimePickerView.reset()
        expEndDateTimePickerView.reset()
        odoFromViewNumberPad.reset()
        odoToViewNumberPad.reset()
        mealTypePicker.reset()
        mealLocationPicker.reset()
        mealAllowancePicker.reset()
        mealMiscTypePicker.reset()
        mealMiscLocationPicker.reset()
        totalAmountNumberPad.reset()
        tipsNumberPad.reset()
        perDiemCheckboxView.reset()
        notesInputView.reset()
        endLatLonLocationSelectView.reset()
        begLatLonSelectView.reset()
        roundTripCheckboxView.reset()
        attachReceiptsImagePickerView.reset()
    }
}
