//
//  ExpenseCoreModel.swift
//  ExpenseApp
//
//  Created by IT Support on 3/22/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

typealias EXP_DTL_CORE_Returned = (_ model: EXP_DTL_CORE?, _ error: Error?) -> Void
typealias EXP_DTL_CORE_ListReturned = (_ models: [EXP_DTL_CORE]?, _ error: Error?) -> Void

struct ExpenseCoreModel {
    var Trip: EXP_HDR_CORE?
    var Expenses: [EXP_DTL_CORE]?
}
