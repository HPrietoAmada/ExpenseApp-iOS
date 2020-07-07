//
//  TripCreateViewController+TripMgmt.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/29/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_HDRViewController {

    func updateTripModel(_ completionHandler: @escaping DataReturned<EXP_HDR>) {
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser, let username = user.username, var model = self.trip else {
                completionHandler(nil, error.toNSError())
                return
            }
            guard let tripName: String = tripNameInputView.field.text, tripName.count > 0 else {
                completionHandler(
                    nil,
                    NSError(
                        domain: "EXP_HDRViewController.updateTripModel",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: "Trip Name required"]
                    )
                )
                return
            }
            /*
            if let awa_model = labeledAWASearchView.model,
                let awa_number = awa_model.AWA_NUMBER {
                model.AWA_NUMBER = awa_number
            }*/
            if let tripTypeValue = tripTypePickerView._value,
                let tripType = tripTypeValue.COLUMN_VALUE, tripType != model.TRIP_TYPE {
                model.TRIP_TYPE = tripType
            }
            model.TRIP_NAME = tripName
            model.BEG_DATE = tripStartTimeView.datePicker.date.toDateTime()
            model.END_DATE = tripEndTimeView.datePicker.date.toDateTime()
            model.CASH_ADVANCED = Double(cashAdvancedHandTextView.field.text ?? "0.0") ?? 0.0
            model.CASH_ON_HAND = Double(cashOnHandTextView.field.text ?? "0.0") ?? 0.0
            model.CO_CODE = user.co_code ?? ""
            model.CHANGED_BY = username
            model.CHANGED_DATE = Date().toDateTime()
            model.NOTES = notesTextInputView._stringValue
            model.PURPOSE = purposeTextInputView.textView.textColor == .placeholder ? "" : purposeTextInputView.textView.text ?? ""
            model.USER_ID = Int(user.user_id)
            completionHandler(
                model,
                NSError(
                    domain: "EXP_HDRViewController.updateTripModel",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "Success"]
                )
            )
        }
    }

    func createTripModel(_ completionHandler: @escaping DataReturned<EXP_HDR>) {
        guard let tripName = tripNameInputView.field.text, tripName.count > 0 else {
            completionHandler(
                nil,
                NSError(
                    domain: "EXP_HDRViewController.createTripModel",
                    code: 400,
                    userInfo: [NSLocalizedDescriptionKey: "Trip Name is Required"]
                )
            )
            return
        }

        if tripStartTimeView.datePicker.date == tripEndTimeView.datePicker.date {
            completionHandler(
                nil,
                NSError(
                    domain: "",
                    code: 300,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid Trip Start and End Dates selected"]
                )
            )
            return
        }

        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser, let username = user.username else {
                completionHandler(nil, error.toNSError())
                return
            }
            var model = EXP_HDR()
            if let tripTypeValue = tripTypePickerView._value, let columnValue = tripTypeValue.COLUMN_VALUE {
                model.TRIP_TYPE = columnValue
            } else {
                model.TRIP_TYPE = "1"
            }
            /*
            if let awa = labeledAWASearchView.model, let awa_number = awa.AWA_NUMBER {
                model.AWA_NUMBER = awa_number
            }*/
            model.BEG_DATE = tripStartTimeView.datePicker.date.toDateTime()
            model.CASH_ADVANCED = Double(cashAdvancedHandTextView.field.text ?? "0.0") ?? 0.0
            model.CASH_ON_HAND = Double(cashOnHandTextView.field.text ?? "0.0") ?? 0.0
            model.COST_CENTER = "IT"
            model.CO_CODE = user.co_code ?? ""
            model.CREATED_BY = username
            model.CREATED_DATE = Date().toDateTime()
            model.CHANGED_BY = username
            model.CHANGED_DATE = Date().toDateTime()
            model.EMP_ID = Int(user.emp_id)
            model.EMP_VENDOR_NUM = user.vendor_num ?? ""
            model.END_DATE = tripEndTimeView.datePicker.date.toDateTime()
            model.NOTES = notesTextInputView._stringValue
            model.PURPOSE = purposeTextInputView.textView.textColor == .placeholder ? "" : purposeTextInputView.textView.text ?? ""
            model.REQUESTED_BY = username
            model.REQUESTED_DATE = Date().toDateTime()
            model.TRIP_NAME = tripName
            model.USER_ID = Int(user.user_id)
            model.EXP_STATUS = "OPEN"
            completionHandler(
                model,
                NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Success"])
            )
        }
    }
}
