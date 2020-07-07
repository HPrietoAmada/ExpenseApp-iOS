//
//  EXP_CHANGE_LOG.swift
//  ExpenseApp
//
//  Created by IT Support on 3/11/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

struct EXP_CHANGE_LOG: Codable {
    public var ID: Int?
    public var LOG_TYPE: String?
    public var CREATED_ID: Int?
    public var CREATED_DATE: String?
    public var TXN_ID: Int?
    public var TABLE_NAME: String?
    public var KEY1_NAME: String?
    public var KEY1_VALUE: String?
    public var KEY2_NAME: String?
    public var KEY2_VALUE: String?
    public var KEY3_NAME: String?
    public var KEY3_VALUE: String?
    public var KEY4_NAME: String?
    public var KEY4_VALUE: String?
    public var COLUMN_NAME: String?
    public var OLD_VALUE: String?
    public var NEW_VALUE: String?
    public var REASON: String?

    init() {
        ID = 0
        LOG_TYPE = ""
        CREATED_ID = 0
        CREATED_DATE = Date().toDateTime()
        TXN_ID = 0
        TABLE_NAME = ""
        KEY1_NAME = ""
        KEY1_VALUE = ""
        KEY2_NAME = ""
        KEY2_VALUE = ""
        KEY3_NAME = ""
        KEY3_VALUE = ""
        KEY4_NAME = ""
        KEY4_VALUE = ""
        COLUMN_NAME = ""
        OLD_VALUE = ""
        NEW_VALUE = ""
        REASON = ""
    }
}
