//
//  ExpenseModel.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/2/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

class ExpenseModel: Codable {
    public var Expense: EXP_DTL?
    public var Guests: [EXP_DTL_GUESTS]?
    public var Files: [EXP_FILES]?
    init() {}
}
