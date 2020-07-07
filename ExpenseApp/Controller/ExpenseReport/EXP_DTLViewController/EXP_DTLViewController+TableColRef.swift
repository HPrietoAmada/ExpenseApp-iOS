//
//  EXP_DTLViewController+TableColRef.swift
//  ExpenseApp
//
//  Created by IT Support on 5/23/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_DTLViewController {
    func getDropdownOptions() {
        CoreDataManager.shared.getAAI_TABLE_COLUMN_REF { (models, error) in
            if error.code >= 300 {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            if let models = models {
                self._tableColRef = models
            }
        }
    }

    func setMealTableColRefPickers(models: [AAI_TABLE_COLUMN_REF]) {
        let mealTypes = models.filter({ $0.COLUMN_NAME == "MEAL_TYPE" })
        let mealLocations = models.filter({ $0.COLUMN_NAME == "MEAL_LOCATION" })
        let mealAllowances = models.filter({ $0.COLUMN_NAME == "MEAL_ALLOWANCE" })
        mealTypePicker.models = mealTypes
        mealLocationPicker.models = mealLocations
        mealAllowancePicker.models = mealAllowances
        mealMiscTypePicker.models = mealTypes
        mealMiscLocationPicker.models = mealLocations
        if let exp_dtl = _expense, let selectedMealType = exp_dtl.MEAL_TYPE {
            if selectedMealType.count < 2 { return }
            if let mealLocationChar = selectedMealType.first,
                let mealTypeChar = selectedMealType.last  {
                // Set MealLocation selected value
                if let mealLocation = mealLocations.first(where: { $0.COLUMN_VALUE == "\(mealLocationChar)" }),
                    let mealLocationDescription = mealLocation.DESCRIPTION {
                    mealLocationPicker._description = mealLocationDescription
                }
                // Set MealType selected Value
                if let mealType = mealTypes.first(where: { $0.COLUMN_VALUE == "\(mealTypeChar)" }),
                    let mealTypeDescription = mealType.DESCRIPTION {
                    mealTypePicker._description = mealTypeDescription
                }

                // Set Meal Allowance selected Value
                if let mealAllowance = mealAllowances.first(where: { $0.COLUMN_VALUE == "\(mealLocationChar)\(mealTypeChar)" }),
                    let mealAllowanceDescription = mealAllowance.DESCRIPTION {
                    mealAllowancePicker._description = mealAllowanceDescription
                }
            }
        }
    }

    func setExpenseTypes(expenseTypes: [AAI_TABLE_COLUMN_REF]) {
        self.expenseTypePicker.models = expenseTypes
        if let expense = self._expense, let expType = expense.EXP_TYPE,
            let expTypeRef = expenseTypes.first(where: { $0.COLUMN_VALUE == expType }) {
            self.expenseTypePicker._value = expTypeRef
            if let expType = expTypeRef.COLUMN_VALUE {
                setExpenseView(expenseType: expType, animated: true)
            }
        } else if let firstExpTypeRef = expenseTypes.first {
            self.expenseTypePicker._value = firstExpTypeRef
            if let expType = firstExpTypeRef.COLUMN_VALUE {
                setExpenseView(expenseType: expType, animated: true)
            }
        }
    }

    func setMileageRates(mileageRates: [AAI_TABLE_COLUMN_REF]) {
        self.odoUOMPicker.models = mileageRates
        if let exp_dtl = self._expense, let description = exp_dtl.ODO_UOM {
            self.odoUOMPicker._description = description
        }
    }
}
