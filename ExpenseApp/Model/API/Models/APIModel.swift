//
//  APIModel.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/9/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

struct APIModel: Codable {
    var ManagerExpenseModels: [TripModel]?
    var ExpenseModels: [TripModel]?
    var TableColRef: [AAI_TABLE_COLUMN_REF]?
    init() {
        ManagerExpenseModels = [TripModel]()
        ExpenseModels = [TripModel]()
        TableColRef = [AAI_TABLE_COLUMN_REF]()
    }
}
