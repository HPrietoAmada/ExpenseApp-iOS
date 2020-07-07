//
//  ExpenseModel.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/8/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

class TripModel: Codable {
    var Trip: EXP_HDR?
    var Expenses: [EXP_DTL]?
    var Guests: [EXP_DTL_GUESTS]?
    var Files: [EXP_FILES]?

    func getExpenseTotal() -> Double? {
        guard let expenses = Expenses else {
            return nil
        }
        var expenseTotal: Double = 0
        expenses.forEach { (expense) in
            if let total = expense.TOTAL_AMOUNT {
                expenseTotal = expenseTotal + total
            }
        }
        return expenseTotal.rounded(toPlaces: 2)
    }

    init() { }

    init(_ coreModel: ExpenseCoreModel) {
        guard let coreTrip = coreModel.Trip, let coreExpenses = coreModel.Expenses else {
            return
        }
        Trip = EXP_HDR(coreTrip)
        var expenses: [EXP_DTL] = [EXP_DTL]()
        coreExpenses.forEach { (coreExpense) in
            expenses.append(EXP_DTL(coreExpense))
        }
        Expenses = expenses
    }

    func createListFromCoreModels(_ coreModels: [ExpenseCoreModel]) -> [TripModel] {
        var expenseModels: [TripModel] = [TripModel]()

        coreModels.forEach { (coreModel) in
            expenseModels.append(TripModel(coreModel))
        }
        return expenseModels
    }
}
