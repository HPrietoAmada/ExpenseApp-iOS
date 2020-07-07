//
//  DBManager.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

typealias StatusReturned = (_ error: NSError) -> Void
typealias DataReturned<T:Encodable> = (_ model: T?, _ error: NSError) -> Void

struct DBManager {
    static let shared = DBManager()
}
