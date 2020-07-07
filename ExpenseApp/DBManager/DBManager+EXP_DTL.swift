//
//  DBManager+EXP_DTL.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/2/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // PUT: api/expense
    func updateExpense(model: EXP_DTL, completionHandler: StatusReturned? = nil) {
        let path: String = "expense"
        put(model, path: path, completionHandler)
    }

    // GET: api/trip/{id}/expenses
    func getTripExpenses(exp_id: Int32, _ completionHandler: @escaping DataReturned<EXP_HDR>) {
        let path: String = "trip/\(exp_id)/expenses"
        get(path, completionHandler)
    }

    // DELETE: api/expense/{id}
    func deleteExpense(id: Int, _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense/\(id)"
        delete(path, completionHandler)
    }

    // POST: api/expense/model
    func createExpenseModel(_ model: ExpenseModel, _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense/model"
        post(model, path: path, completionHandler)
    }

    func createExpense(_ model: EXP_DTL, _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense"
        post(model, path: path, completionHandler)
    }

    // PUT: api/expense/{id}/username/{username}/notes/{notes}
    func sendExpenseNotes(id: Int, username: String, notes: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense/\(id)/username/\(username)/notes/\(notes)"
        put(path, completionHandler)
    }

}
