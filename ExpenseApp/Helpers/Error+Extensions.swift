//
//  Error+Extensions.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/8/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

extension Error {

    func toNSError(domain: String = "",code: Int = 400) -> NSError {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
