//
//  User.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/26/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

struct User: Codable {
    public var USER_ID: Int?
    public var PASSWORD: String?
    public var EMAIL: String?
    public var NAME_FIRST: String?
    public var NAME_LAST: String?
    public var TITLE: String?
    public var REPORTS_TO: Int?
    public var COMPANY_ID: Int?
    public var COMPANY_CODE: String?
    public var DIVISION_ID: Int?
    public var DIVISION_CODE: String?
    public var DEPARTMENT_ID: Int?
    public var OFFICE_ID: Int?
    public var REGION_ID: Int?
    public var SBU_ID: Int?
    public var SALES_NUM: Int?
    public var HOME_DEPT: String?
    public var VENDOR_NUM: String?
    public var REP_CODE: String?
    public var SERVICE_ROLE: String?
    public var PHONE: String?
    public var EXT: String?
    public var FAX: String?
    public var PAGER: String?
    public var CELL:String?
    public var CELL_PROVIDER: String?
    public var MOBILE_EMAIL: String?
    public var HOME_ADDRESS: String?
    public var HOME_CITY: String?
    public var HOME_STATE: String?
    public var HOME_ZIP: String?
    public var HOME_WORKPHONE: String?
    public var HOME_PHONE: String?
    public var HOME_FAX: String?
    public var PHOTO_URL: String?
    public var IS_DELETED: String?
    public var CREATED: String?
    public var UPDATED: String?
    public var CREATED_ID: Int?
    public var UPDATED_ID: Int?
    public var HOME_LAT: Double?
    public var HOME_LON: Double?
    public var ANDROID_ID: String?
    public var PLANT: String?
    public var REGION_ID_SERVICE: Int?
    public var LANGUAGE: String?
    public var CO_CODE: String?
    public var USERNAME: String?
    public var PASSWORD_AD: String?
    public var EMP_ID: Int?
    public var PREFER_NAME_FIRST: String?
    public var PREFER_NAME_LAST: String?
    public var SAP_ACCESS_GRP: String?
    public var HIRE_DATE: String?
    public var DISPLAY_NAME: String?
    init() {
        self.USER_ID = 0
        self.EMP_ID = 0
        self.DISPLAY_NAME = ""
        self.CREATED = ""
        self.CREATED_ID = 0
        self.NAME_FIRST = ""
        self.NAME_LAST = ""
        self.TITLE = ""
        self.REPORTS_TO = 0
        self.COMPANY_ID = 0
        self.COMPANY_CODE = ""
        self.DIVISION_ID = 0
        self.DIVISION_CODE = ""
        self.DEPARTMENT_ID = 0
        self.OFFICE_ID = 0
        self.REGION_ID = 0
        self.SBU_ID = 0
        self.SALES_NUM = 0
        self.HOME_DEPT = ""
        self.VENDOR_NUM = ""
        self.REP_CODE = ""
        self.SERVICE_ROLE = ""
        self.PHONE = ""
        self.EXT = ""
        self.FAX = ""
        self.PAGER = ""
        self.CELL = ""
        self.CELL_PROVIDER = ""
        self.MOBILE_EMAIL = ""
        self.HOME_ADDRESS = ""
        self.HOME_CITY = ""
        self.HOME_STATE = ""
        self.HOME_ZIP = ""
        self.HOME_WORKPHONE = ""
        self.HOME_PHONE  = ""
        self.HOME_FAX = ""
        self.PHOTO_URL = ""
        self.IS_DELETED = ""
        self.UPDATED_ID = 0
        self.HOME_LAT = 0
        self.HOME_LON = 0
        self.ANDROID_ID = ""
        self.PLANT = ""
        self.REGION_ID_SERVICE = 0
        self.LANGUAGE = ""
        self.CO_CODE = ""
        self.USERNAME = ""
        self.PASSWORD_AD = ""
        self.PREFER_NAME_LAST = ""
        self.PREFER_NAME_FIRST = ""
        self.SAP_ACCESS_GRP = ""
        self.HIRE_DATE = ""
    }
}
