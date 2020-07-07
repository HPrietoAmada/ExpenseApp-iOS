//
//  ManagerExpenseModel.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/9/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

struct ManagerExpenseModel: Codable {
    var displayName: String?
    var expenses: [TripModel]?
}
