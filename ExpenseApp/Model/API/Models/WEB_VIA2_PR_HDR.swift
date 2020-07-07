//
//  WEB_VIA2_PR_HDR.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/14/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

struct WEB_VIA2_PR_HDR: Codable {
    public var ID: Int?
    public var PURPOSE: String?
    public var REQUESTED_BY: String?
    public var CREATED_DATE: String?
    public var AWA_NUMBER: String?

    init() {
        self.ID = 0
        self.PURPOSE = ""
        self.REQUESTED_BY = ""
        self.CREATED_DATE = ""
        self.AWA_NUMBER = ""
    }
}
