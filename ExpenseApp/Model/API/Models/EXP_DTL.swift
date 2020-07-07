//
//  EXP_DTL.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

typealias EXP_DTL_Returned = (_ model: EXP_DTL?, _ error: Error?) -> Void
typealias EXP_DTL_ListReturned = (_ models: [EXP_DTL]?, _ error: Error?) -> Void

struct EXP_DTL: Codable {
    public var ID: Int?
    public var EXP_ID: Int?
    public var EXP_LINE: Int?
    public var EXP_DESC: String?
    public var EXP_TYPE: String?
    public var EXP_BEG_DATE: String?
    public var EXP_END_DATE: String?
    public var MEAL_TYPE: String?
    public var MEAL_LOCATION: String?
    public var CURRENCY: String?
    public var TOTAL_AMOUNT: Double?
    public var NET_AMOUNT: Double?
    public var TIPS_AMOUNT: Double?
    public var EXC_RATE: Double?
    public var ROUND_TRIP_FLAG: String?
    public var ODO_UOM: String?
    public var ODO_FROM: Double?
    public var ODO_TO: Double?
    public var BEG_LAT: Double?
    public var BEG_LON: Double?
    public var END_LAT: Double?
    public var END_LON: Double?
    public var MILEAGE_RATE: Double?
    public var BEG_LOC_NAME: String?
    public var BEG_LOC_ADDR1: String?
    public var BEG_LOC_ADDR2: String?
    public var BEG_LOC_CITY: String?
    public var BEG_LOC_STATE: String?
    public var BEG_LOC_ZIP: String?
    public var BEG_LOC_COUNTRY: String?
    public var END_LOC_NAME: String?
    public var END_LOC_ADDR1: String?
    public var END_LOC_ADDR2: String?
    public var END_LOC_CITY: String?
    public var END_LOC_STATE: String?
    public var END_LOC_ZIP: String?
    public var END_LOC_COUNTRY: String?
    public var CREATED_DATE: String?
    public var CREATED_BY: String?
    public var CHANGED_DATE: String?
    public var CHANGED_BY: String?
    public var NOTES: String?
    public var PER_DIEM_FLAG: String?
    public var GL_ACCOUNT: String?

    // Added
    public var FILES_COUNT: Double?
    public var EXP_BEG_DATE_FORMATTED: String?
    public var EXP_END_DATE_FORMATTED: String?
    public var EXP_TYPE_DESCRIPTION: String?
    public var EXP_BEG_DATE_STR: String?
    public var EXP_END_DATE_STR: String?
    public var CREATED_DATE_FORMATTED: String?
    public var CHANGED_DATE_FORMATTED: String?
    /*
    let IS_SUMMARY : Bool?
    let Paid : Bool?
    let ExportItem : Bool?
    let DynamicProperties : [String]?
    let IS_DELETED : String?
    let HISTORY_LINK : String?
    let History : [String]?
    let EditColumnBool : Bool?
    let ReadOnlyBool : Bool?
    let HistoryColumnsOverride : String?
 */

    enum CodingKeys: String, CodingKey {

        case ID = "ID"
        case EXP_ID = "EXP_ID"
        case EXP_LINE = "EXP_LINE"
        case EXP_TYPE = "EXP_TYPE"
        case EXP_DESC = "EXP_DESC"
        case EXP_BEG_DATE = "EXP_BEG_DATE"
        case EXP_END_DATE = "EXP_END_DATE"
        case MEAL_TYPE = "MEAL_TYPE"
        case MEAL_LOCATION = "MEAL_LOCATION"
        case CURRENCY = "CURRENCY"
        case TOTAL_AMOUNT = "TOTAL_AMOUNT"
        case NET_AMOUNT = "NET_AMOUNT"
        case TIPS_AMOUNT = "TIPS_AMOUNT"
        case EXC_RATE = "EXC_RATE"
        case ROUND_TRIP_FLAG = "ROUND_TRIP_FLAG"
        case ODO_UOM = "ODO_UOM"
        case ODO_FROM = "ODO_FROM"
        case ODO_TO = "ODO_TO"
        case BEG_LAT = "BEG_LAT"
        case BEG_LON = "BEG_LON"
        case END_LAT = "END_LAT"
        case END_LON = "END_LON"
        case MILEAGE_RATE = "MILEAGE_RATE"
        case BEG_LOC_NAME = "BEG_LOC_NAME"
        case BEG_LOC_ADDR1 = "BEG_LOC_ADDR1"
        case BEG_LOC_ADDR2 = "BEG_LOC_ADDR2"
        case BEG_LOC_CITY = "BEG_LOC_CITY"
        case BEG_LOC_STATE = "BEG_LOC_STATE"
        case BEG_LOC_ZIP = "BEG_LOC_ZIP"
        case BEG_LOC_COUNTRY = "BEG_LOC_COUNTRY"
        case END_LOC_NAME = "END_LOC_NAME"
        case END_LOC_ADDR1 = "END_LOC_ADDR1"
        case END_LOC_ADDR2 = "END_LOC_ADDR2"
        case END_LOC_CITY = "END_LOC_CITY"
        case END_LOC_STATE = "END_LOC_STATE"
        case END_LOC_ZIP = "END_LOC_ZIP"
        case END_LOC_COUNTRY = "END_LOC_COUNTRY"
        case CREATED_DATE = "CREATED_DATE"
        case CREATED_BY = "CREATED_BY"
        case CHANGED_DATE = "CHANGED_DATE"
        case CHANGED_BY = "CHANGED_BY"
        case NOTES = "NOTES"
        case PER_DIEM_FLAG = "PER_DIEM_FLAG"
        case GL_ACCOUNT = "GL_ACCOUNT"
        case FILES_COUNT = "FILES_COUNT"
        case EXP_BEG_DATE_FORMATTED = "EXP_BEG_DATE_FORMATTED"
        case EXP_END_DATE_FORMATTED = "EXP_END_DATE_FORMATTED"
        case EXP_TYPE_DESCRIPTION = "EXP_TYPE_DESCRIPTION"
        case EXP_BEG_DATE_STR = "EXP_BEG_DATE_STR"
        case EXP_END_DATE_STR = "EXP_END_DATE_STR"
        case CREATED_DATE_FORMATTED = "CREATED_DATE_FORMATTED"
        case CHANGED_DATE_FORMATTED = "CHANGED_DATE_FORMATTED"
        /*
        case IS_SUMMARY = "IS_SUMMARY"
        case Paid = "Paid"
        case ExportItem = "ExportItem"
        case DynamicProperties = "DynamicProperties"
        case IS_DELETED = "IS_DELETED"
        case HISTORY_LINK = "HISTORY_LINK"
        case History = "History"
        case EditColumnBool = "EditColumnBool"
        case ReadOnlyBool = "ReadOnlyBool"
        case HistoryColumnsOverride = "HistoryColumnsOverride"*/
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ID = try values.decodeIfPresent(Int.self, forKey: .ID)
        EXP_ID = try values.decodeIfPresent(Int.self, forKey: .EXP_ID)
        EXP_LINE = try values.decodeIfPresent(Int.self, forKey: .EXP_LINE)
        EXP_TYPE = try values.decodeIfPresent(String.self, forKey: .EXP_TYPE)
        EXP_DESC = try values.decodeIfPresent(String.self, forKey: .EXP_DESC)
        EXP_BEG_DATE = try values.decodeIfPresent(String.self, forKey: .EXP_BEG_DATE)
        EXP_END_DATE = try values.decodeIfPresent(String.self, forKey: .EXP_END_DATE)
        MEAL_TYPE = try values.decodeIfPresent(String.self, forKey: .MEAL_TYPE)
        MEAL_LOCATION = try values.decodeIfPresent(String.self, forKey: .MEAL_LOCATION)
        CURRENCY = try values.decodeIfPresent(String.self, forKey: .CURRENCY)
        TOTAL_AMOUNT = try values.decodeIfPresent(Double.self, forKey: .TOTAL_AMOUNT)
        NET_AMOUNT = try values.decodeIfPresent(Double.self, forKey: .NET_AMOUNT)
        TIPS_AMOUNT = try values.decodeIfPresent(Double.self, forKey: .TIPS_AMOUNT)
        EXC_RATE = try values.decodeIfPresent(Double.self, forKey: .EXC_RATE)
        ROUND_TRIP_FLAG = try values.decodeIfPresent(String.self, forKey: .ROUND_TRIP_FLAG)
        ODO_UOM = try values.decodeIfPresent(String.self, forKey: .ODO_UOM)
        ODO_FROM = try values.decodeIfPresent(Double.self, forKey: .ODO_FROM)
        ODO_TO = try values.decodeIfPresent(Double.self, forKey: .ODO_TO)
        BEG_LAT = try values.decodeIfPresent(Double.self, forKey: .BEG_LAT)
        BEG_LON = try values.decodeIfPresent(Double.self, forKey: .BEG_LON)
        END_LAT = try values.decodeIfPresent(Double.self, forKey: .END_LAT)
        END_LON = try values.decodeIfPresent(Double.self, forKey: .END_LON)
        MILEAGE_RATE = try values.decodeIfPresent(Double.self, forKey: .MILEAGE_RATE)
        BEG_LOC_NAME = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_NAME)
        BEG_LOC_ADDR1 = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_ADDR1)
        BEG_LOC_ADDR2 = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_ADDR2)
        BEG_LOC_CITY = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_CITY)
        BEG_LOC_STATE = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_STATE)
        BEG_LOC_ZIP = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_ZIP)
        BEG_LOC_COUNTRY = try values.decodeIfPresent(String.self, forKey: .BEG_LOC_COUNTRY)
        END_LOC_NAME = try values.decodeIfPresent(String.self, forKey: .END_LOC_NAME)
        END_LOC_ADDR1 = try values.decodeIfPresent(String.self, forKey: .END_LOC_ADDR1)
        END_LOC_ADDR2 = try values.decodeIfPresent(String.self, forKey: .END_LOC_ADDR2)
        END_LOC_CITY = try values.decodeIfPresent(String.self, forKey: .END_LOC_CITY)
        END_LOC_STATE = try values.decodeIfPresent(String.self, forKey: .END_LOC_STATE)
        END_LOC_ZIP = try values.decodeIfPresent(String.self, forKey: .END_LOC_ZIP)
        END_LOC_COUNTRY = try values.decodeIfPresent(String.self, forKey: .END_LOC_COUNTRY)
        CREATED_DATE = try values.decodeIfPresent(String.self, forKey: .CREATED_DATE)
        CREATED_BY = try values.decodeIfPresent(String.self, forKey: .CREATED_BY)
        CHANGED_DATE = try values.decodeIfPresent(String.self, forKey: .CHANGED_DATE)
        CHANGED_BY = try values.decodeIfPresent(String.self, forKey: .CHANGED_BY)
        NOTES = try values.decodeIfPresent(String.self, forKey: .NOTES)
        PER_DIEM_FLAG = try values.decodeIfPresent(String.self, forKey: .PER_DIEM_FLAG)
        GL_ACCOUNT = try values.decodeIfPresent(String.self, forKey: .GL_ACCOUNT)
        FILES_COUNT = try values.decodeIfPresent(Double.self, forKey: .FILES_COUNT)
        EXP_BEG_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .EXP_BEG_DATE_FORMATTED)
        EXP_END_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .EXP_END_DATE_FORMATTED)
        EXP_TYPE_DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .EXP_TYPE_DESCRIPTION)
        EXP_BEG_DATE_STR = try values.decodeIfPresent(String.self, forKey: .EXP_BEG_DATE_STR)
        EXP_END_DATE_STR = try values.decodeIfPresent(String.self, forKey: .EXP_END_DATE_STR)
        CREATED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .CREATED_DATE_FORMATTED)
        CHANGED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .CHANGED_DATE_FORMATTED)
        /*IS_SUMMARY = try values.decodeIfPresent(Bool.self, forKey: .IS_SUMMARY)
        Paid = try values.decodeIfPresent(Bool.self, forKey: .Paid)
        ExportItem = try values.decodeIfPresent(Bool.self, forKey: .ExportItem)
        DynamicProperties = try values.decodeIfPresent([String].self, forKey: .DynamicProperties)
        IS_DELETED = try values.decodeIfPresent(String.self, forKey: .IS_DELETED)
        HISTORY_LINK = try values.decodeIfPresent(String.self, forKey: .HISTORY_LINK)
        History = try values.decodeIfPresent([String].self, forKey: .History)
        EditColumnBool = try values.decodeIfPresent(Bool.self, forKey: .EditColumnBool)
        ReadOnlyBool = try values.decodeIfPresent(Bool.self, forKey: .ReadOnlyBool)
        HistoryColumnsOverride = try values.decodeIfPresent(String.self, forKey: .HistoryColumnsOverride)*/
    }

    init(_ model: EXP_DTL_CORE) {
        ID = Int(model.id)
        EXP_ID = Int(model.exp_id)
        EXP_LINE = Int(model.exp_line)
        EXP_DESC = model.exp_desc
        EXP_TYPE = "\(Int(model.exp_type))"
        EXP_BEG_DATE = model.exp_beg_date
        EXP_END_DATE = model.exp_end_date
        MEAL_TYPE = model.meal_type
        MEAL_LOCATION = model.meal_location
        CURRENCY = model.currency
        TOTAL_AMOUNT = model.total_amount
        NET_AMOUNT = model.net_amount
        TIPS_AMOUNT = model.tips_amount
        EXC_RATE = model.exc_rate
        ROUND_TRIP_FLAG = model.round_trip_flag
        ODO_UOM = model.odo_uom
        ODO_FROM = model.odo_from
        ODO_TO = model.odo_to
        BEG_LAT = model.beg_lat
        BEG_LON = model.beg_lon
        END_LAT = model.end_lat
        END_LON = model.end_lon
        MILEAGE_RATE = model.mileage_rate
        BEG_LOC_NAME = model.beg_loc_name
        BEG_LOC_ADDR1 = model.beg_loc_addr1
        BEG_LOC_ADDR2 = model.beg_loc_addr2
        BEG_LOC_CITY = model.beg_loc_city
        BEG_LOC_STATE = model.beg_loc_state
        BEG_LOC_ZIP = model.beg_loc_zip
        BEG_LOC_COUNTRY = model.beg_loc_country
        END_LOC_NAME = model.end_loc_name
        END_LOC_ADDR1 = model.end_loc_addr1
        END_LOC_ADDR2 = model.end_loc_addr2
        END_LOC_CITY = model.end_loc_city
        END_LOC_STATE = model.end_loc_state
        END_LOC_ZIP = model.end_loc_zip
        END_LOC_COUNTRY = model.end_loc_country
        CREATED_DATE = model.created_date
        CREATED_BY = model.created_by
        CHANGED_DATE = model.changed_date
        CHANGED_BY = model.changed_by
        NOTES = model.notes
        PER_DIEM_FLAG = model.per_diem_flag
        GL_ACCOUNT = model.gl_account

        FILES_COUNT = nil
        EXP_BEG_DATE_FORMATTED = nil
        EXP_END_DATE_FORMATTED = nil
        EXP_TYPE_DESCRIPTION = nil
        EXP_BEG_DATE_STR = nil
        EXP_END_DATE_STR = nil
        CREATED_DATE_FORMATTED = nil
        CHANGED_DATE_FORMATTED = nil
        /*IS_SUMMARY = nil
        Paid = nil
        ExportItem = nil
        DynamicProperties = nil
        IS_DELETED = nil
        HISTORY_LINK = nil
        History = nil
        EditColumnBool = nil
        ReadOnlyBool = nil
        HistoryColumnsOverride = nil*/
    }

    init() {
        ID = 0
        EXP_ID = 0
        EXP_LINE = 0
        EXP_DESC = ""
        EXP_TYPE = "0"
        EXP_BEG_DATE = Date().toDateTime()
        EXP_END_DATE = Date().toDateTime()
        MEAL_TYPE = ""
        CURRENCY = ""
        TOTAL_AMOUNT = 0.0
        NET_AMOUNT = 0.0
        TIPS_AMOUNT = 0.0
        EXC_RATE = 0.0
        ROUND_TRIP_FLAG = ""
        ODO_UOM = ""
        ODO_FROM = 0
        ODO_TO = 0
        BEG_LAT = 0
        BEG_LON = 0
        END_LAT = 0
        END_LON = 0
        MILEAGE_RATE = 0
        BEG_LOC_NAME = ""
        BEG_LOC_ADDR1 = ""
        BEG_LOC_ADDR2 = ""
        BEG_LOC_CITY = ""
        BEG_LOC_STATE = ""
        BEG_LOC_ZIP = ""
        BEG_LOC_COUNTRY = ""
        END_LOC_NAME = ""
        END_LOC_ADDR1 = ""
        END_LOC_ADDR2 = ""
        END_LOC_CITY = ""
        END_LOC_STATE = ""
        END_LOC_ZIP = ""
        END_LOC_COUNTRY = ""
        CREATED_DATE = Date().toDateTime()
        CREATED_BY = ""
        CHANGED_DATE = Date().toDateTime()
        CHANGED_BY = ""
        NOTES = ""
        PER_DIEM_FLAG = ""
        GL_ACCOUNT = ""
        FILES_COUNT = nil
        EXP_BEG_DATE_FORMATTED = nil
        EXP_END_DATE_FORMATTED = nil
        EXP_TYPE_DESCRIPTION = nil
        EXP_BEG_DATE_STR = nil
        EXP_END_DATE_STR = nil
        CREATED_DATE_FORMATTED = nil
        CHANGED_DATE_FORMATTED = nil
        /*IS_SUMMARY = nil
        Paid = nil
        ExportItem = nil
        DynamicProperties = nil
        IS_DELETED = nil
        HISTORY_LINK = nil
        History = nil
        EditColumnBool = nil
        ReadOnlyBool = nil
        HistoryColumnsOverride = nil*/
    }
}
