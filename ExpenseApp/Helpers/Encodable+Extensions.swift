//
//  Encodable+Extensions.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/17/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSON() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
