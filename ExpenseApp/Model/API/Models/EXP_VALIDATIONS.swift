//
//  EXP_VALIDATIONS.swift
//  ExpenseApp
//
//  Created by IT Support on 3/11/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

struct EXP_VALIDATIONS: Codable {
    public var ID: Int?
    public var EXP_GROUP: String?
    public var EXP_CAT: String?
    public var STATUS: String?
    public var IS_DELETED: String?
    public var IS_REQUIRED: String?
    public var EXP_VALIDATION: Int?
    public var CREATED_DATE: String?
    public var CREATED_BY: String?
    public var CHANGED_DATE: String?
    public var CHANGED_BY: String?
    init() {
        ID = 0
        EXP_GROUP = ""
        EXP_CAT = ""
        STATUS = ""
        IS_DELETED = ""
        IS_REQUIRED = ""
        EXP_VALIDATION = 0
        CREATED_DATE = ""
        CREATED_BY = ""
        CHANGED_DATE = ""
        CHANGED_BY = ""
    }
}
