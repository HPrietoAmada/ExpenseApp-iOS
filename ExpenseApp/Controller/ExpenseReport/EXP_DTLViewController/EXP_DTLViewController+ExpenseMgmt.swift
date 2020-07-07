//
//  CreateExpenseController+ExpenseMgmt.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/25/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_DTLViewController {

    func createEXP_DTLFromFields(completionHandler: DataReturned<EXP_DTL>) {
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser,
                let username = user.username,
                let selectedExpense = expenseTypePicker._value else {
                    return
            }
            var expenseFields = [AAI_TABLE_COLUMN_REF]()

            var model = EXP_DTL()
            if let expense = self._expense {
                model = expense
                expenseFields = _tableColRef.filter({
                    $0.COLUMN_NAME == "EXP_TYPE_FIELD" && $0.ATTRIBUTE1 == model.EXP_TYPE
                })
            } else if let trip = exp_hdr,
                let expId = trip.ID,
                let expType = selectedExpense.COLUMN_VALUE,
                let expDesc = selectedExpense.DESCRIPTION {
                model.EXP_TYPE = expType
                model.EXP_DESC = expDesc
                model.EXP_ID = expId
                expenseFields = _tableColRef.filter({
                    $0.COLUMN_NAME == "EXP_TYPE_FIELD" && $0.ATTRIBUTE1 == expType
                })
                model.CREATED_BY = username
                model.CHANGED_BY = username
            } else {
                return
            }
            model.CHANGED_BY = user.username

            var totalAmount: Double = 0
            let tipAmount: Double = Double(tipsNumberPad.field.text ?? "0.0") ?? 0.0
            let mileageRate: Double = Double(odoUOMPicker._value?.COLUMN_VALUE ?? "0.0") ?? 0.0

            let begDate = expBegDateTimePickerView.datePicker.date
            let endDate = expEndDateTimePickerView.datePicker.date

            let originNotSelected = begLatLonSelectView.place == nil
            let destinationNotSelected = endLatLonLocationSelectView.place == nil
            let perDiem: Bool = perDiemCheckboxView.isChecked
            let roundTrip: Bool = roundTripCheckboxView.isChecked
            
            expenseFields.forEach { (expenseField) in
                switch expenseField.COLUMN_VALUE {
                case "*ADD_GUESTS":
                    break
                case "*ATTACH_RECEIPTS":
                    break
                case "BEG_LAT_LON":
                    if perDiem { break }
                    if let origin = begLatLonSelectView.place {
                        model.BEG_LON = Double(origin.coordinate.longitude)
                        model.BEG_LAT = Double(origin.coordinate.latitude)
                        model.BEG_LOC_NAME = origin.name?.replacingOccurrences(of: "\'", with: "")
                        model.BEG_LOC_ADDR2 = origin.placeID
                        if let originAddr = origin.formattedAddress {
                            let addrComps = originAddr.components(separatedBy: ",")
                            let nComps = addrComps.count
                            model.BEG_LOC_ADDR1 = nComps >= 1 ? addrComps[0].replacingOccurrences(of: "\'", with: "") : ""
                            model.BEG_LOC_STATE = addrComps[2].components(separatedBy: " ")[1]
                            model.BEG_LOC_CITY = nComps >= 2 ? addrComps[1] : ""
                            model.BEG_LOC_COUNTRY = nComps >= 4 ? addrComps[3] : ""
                        }
                        /*
                        if let originComps = origin.addressComponents {
                            for comp in originComps {
                                switch comp.type {
                                case "postal_code":
                                    model.BEG_LOC_ZIP = comp.name
                                    break
                                default: break
                                }
                            }
                        }*/
                    }
                    break
                case "CURRENCY":
                    break
                case "END_LAT_LON":
                    if perDiem { break }
                    if let destination = endLatLonLocationSelectView.place {
                        model.END_LON = Double(destination.coordinate.longitude)
                        model.END_LAT = Double(destination.coordinate.latitude)
                        model.END_LOC_NAME = destination.name?.replacingOccurrences(of: "\'", with: "")
                        model.END_LOC_ADDR2 = destination.placeID
                        if let destAddr = destination.formattedAddress {
                            let addrComps = destAddr.components(separatedBy: ",")
                            let nComps = addrComps.count
                            model.END_LOC_ADDR1 = nComps >= 1 ? addrComps[0].replacingOccurrences(of: "\'", with: "") : ""
                            model.END_LOC_CITY = nComps >= 2 ? addrComps[1] : ""
                            model.END_LOC_STATE = addrComps[2].components(separatedBy: " ")[1]
                            model.END_LOC_COUNTRY = nComps >= 4 ? addrComps[3] : ""
                            /*
                            if let destinationComps = destination.addressComponents {
                                for comp in destinationComps {
                                    switch comp.type {
                                    case "postal_code":
                                        model.END_LOC_ZIP = comp.name
                                        break
                                    default: break
                                    }
                                }
                            }*/
                        }
                    }

                    // calculate total amount from miles travaled
                    if let origin = begLatLonSelectView.place,
                        let destination = endLatLonLocationSelectView.place,
                        let odomUOM = odoUOMPicker._value, let odomUOMDescription = odomUOM.DESCRIPTION {
                        model.ODO_UOM = odomUOMDescription
                        let milesTraveled = origin.miles(to: destination, uom: model.ODO_UOM ?? "MI")
                        let mileageCost = (milesTraveled * mileageRate) * (roundTripCheckboxView.isChecked ? 2 : 1)
                        totalAmount = totalAmount + mileageCost
                    }
                    model.MILEAGE_RATE = mileageRate
                    break
                case "EXP_BEG_DATE":
                    model.EXP_BEG_DATE = begDate.toDateTime()
                    break
                case "EXP_END_DATE":
                    model.EXP_END_DATE = endDate.toDateTime()
                    break
                case "MEAL_TYPE":
                    
                    let isPerDiem = perDiemCheckboxView.isChecked
                    /*
                     If PerDiem checkbox is checked, we don't need mealType value since
                     the mealTypes are autogenerated based on the begin/end date
                     */
                    if !isPerDiem {
                        if let mealTypeRef = mealTypePicker._value,
                            let mealTypeValue = mealTypeRef.COLUMN_VALUE {
                            model.MEAL_TYPE = mealTypeValue
                        }
                    }
                    if let mealLocationRef = mealLocationPicker._value,
                        let mealLocationValue = mealLocationRef.COLUMN_VALUE {
                        model.MEAL_LOCATION = mealLocationValue
                    }
                    break
                case "MEAL_LOCATION":
                    if let mealLocationRef = mealLocationPicker._value,
                        let mealLocationValue = mealLocationRef.COLUMN_VALUE {
                        model.MEAL_LOCATION = mealLocationValue
                    }
                    break
                case "NET_AMOUNT":
                    let netAmount = Double(totalAmountNumberPad.field.text ?? "0.0") ?? 0.0
                    model.NET_AMOUNT = netAmount
                    if !perDiem {
                        totalAmount = totalAmount + netAmount
                    }
                    break
                case "NOTES":
                    model.NOTES = notesInputView.textView.textColor == .placeholder ? "" : notesInputView.textView.text ?? ""
                    break
                case "ODO_FROM":
                    if let odoFrom = odoFromViewNumberPad.field.text {
                        model.ODO_FROM = Double(odoFrom) ?? 0.0
                    }
                    break
                case "ODO_TO":
                    if let odoTo = odoToViewNumberPad.field.text {
                        model.ODO_TO = Double(odoTo) ?? 0.0

                        if (originNotSelected || destinationNotSelected) {
                            totalAmount = totalAmount + getMileageCost()
                        }
                    }
                    break
                case "ODO_UOM":
                    model.ODO_UOM = odoUOMPicker._value?.DESCRIPTION ?? "MI"
                    break
                case "PER_DIEM_FLAG":
                    model.PER_DIEM_FLAG = perDiem ? "Y" : "N"
                    break
                case "ROUND_TRIP_FLAG":
                    model.ROUND_TRIP_FLAG = roundTrip ? "Y" : "N"
                    break
                case "TIPS_AMOUNT":
                    model.TIPS_AMOUNT = tipAmount
                    totalAmount = totalAmount + tipAmount
                    break
                case "MISC_MEAL_TYPE":
                    if let mealMiscLocationModel = mealMiscLocationPicker._value,
                        let mealMiscLocationValue = mealMiscLocationModel.COLUMN_VALUE {
                        model.MEAL_LOCATION = mealMiscLocationValue
                    }
                    if let mealMiscTypeModel = mealMiscTypePicker._value,
                        let mealMiscTypeValue = mealMiscTypeModel.COLUMN_VALUE {
                        model.MEAL_TYPE = mealMiscTypeValue
                    }
                default: break
                }
            }
            model.TOTAL_AMOUNT = totalAmount
            completionHandler(
                model,
                NSError(
                    domain: "",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey : "Success"]
            ))
        }
    }

    /*
     Gets odometer start and end values, gets the mileage rate
     and calculates the total being reinbursed
     */
    func getMileageCost() -> Double {
        guard let odo_to_str = odoToViewNumberPad.field.text,
            let odo_from_str = odoFromViewNumberPad.field.text,
            let odo_to = Double(odo_to_str),
            let odo_from = Double(odo_from_str),
            let mileageRate = getMileageGasRate() else {
                return 0
        }
        return (odo_to - odo_from) * mileageRate
    }

    func getEXP_Values() -> (exp_id: Int?, id: Int?, exp_line: Int?) {
        if let exp_dtl = _expense {
            return (exp_dtl.EXP_ID, exp_dtl.ID, exp_dtl.EXP_LINE)
        } else {
            if let exp_hdr = exp_hdr {
                return (exp_hdr.ID, nil, 1)
            }
        }
        return (nil,nil,nil)
    }
}
