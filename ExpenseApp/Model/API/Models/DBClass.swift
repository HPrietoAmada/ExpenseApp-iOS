//
//  DBClass.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/9/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

struct DBClass: Codable {
    public var IS_SUMMARY: Bool?
    public var Paid: Bool?
    public var ExportItem: Bool?
    public var DynamicProperties: [String]?
    public var IS_DELETED: Bool?
    public var HISTORY_LINK: String?
    public var History: [String]?
    public var EditColumnBool: Bool?
    public var ReadOnlyBool: Bool?
    public var HistoryColumnsOverride: String?

    init() {

    }
}
