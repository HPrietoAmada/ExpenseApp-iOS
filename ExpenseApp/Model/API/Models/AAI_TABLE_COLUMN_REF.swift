//
//  AAI_TABLE_COLUMN_REF.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/21/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

typealias tableColRef_CORE_ListReturned = ([AAI_TABLE_COLUMN_REF_CORE]?, Error?) -> Void
typealias tableColRef_CORE_Returned = (AAI_TABLE_COLUMN_REF_CORE?, Error?) -> Void

struct AAI_TABLE_COLUMN_REF: Codable {
    let TABLE_NAME : String?
    let COLUMN_NAME : String?
    let COLUMN_VALUE : String?
    let DESCRIPTION : String?
    let COMMENTS : String?
    let ACTIVE_STATUS : String?
    let SOURCE : String?
    let CREATED_DATE : String?
    let CREATED_BY : String?
    let CHANGED_DATE : String?
    let CHANGED_BY : String?
    let SORT_ORDER : Double?
    let CO_CODE : String?
    let ATTRIBUTE1 : String?
    let ATTRIBUTE2 : String?
    let ATTRIBUTE3 : String?
    let COMMENTS2 : String?
    let FRENCH_DESCRIPTION : String?
    let SPANISH_DESCRIPTION : String?
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

    enum CodingKeys: String, CodingKey {

        case TABLE_NAME = "TABLE_NAME"
        case COLUMN_NAME = "COLUMN_NAME"
        case COLUMN_VALUE = "COLUMN_VALUE"
        case DESCRIPTION = "DESCRIPTION"
        case COMMENTS = "COMMENTS"
        case ACTIVE_STATUS = "ACTIVE_STATUS"
        case SOURCE = "SOURCE"
        case CREATED_DATE = "CREATED_DATE"
        case CREATED_BY = "CREATED_BY"
        case CHANGED_DATE = "CHANGED_DATE"
        case CHANGED_BY = "CHANGED_BY"
        case SORT_ORDER = "SORT_ORDER"
        case CO_CODE = "CO_CODE"
        case ATTRIBUTE1 = "ATTRIBUTE1"
        case ATTRIBUTE2 = "ATTRIBUTE2"
        case ATTRIBUTE3 = "ATTRIBUTE3"
        case COMMENTS2 = "COMMENTS2"
        case FRENCH_DESCRIPTION = "FRENCH_DESCRIPTION"
        case SPANISH_DESCRIPTION = "SPANISH_DESCRIPTION"
        case IS_SUMMARY = "IS_SUMMARY"
        case Paid = "Paid"
        case ExportItem = "ExportItem"
        case DynamicProperties = "DynamicProperties"
        case IS_DELETED = "IS_DELETED"
        case HISTORY_LINK = "HISTORY_LINK"
        case History = "History"
        case EditColumnBool = "EditColumnBool"
        case ReadOnlyBool = "ReadOnlyBool"
        case HistoryColumnsOverride = "HistoryColumnsOverride"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        TABLE_NAME = try values.decodeIfPresent(String.self, forKey: .TABLE_NAME)
        COLUMN_NAME = try values.decodeIfPresent(String.self, forKey: .COLUMN_NAME)
        COLUMN_VALUE = try values.decodeIfPresent(String.self, forKey: .COLUMN_VALUE)
        DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .DESCRIPTION)
        COMMENTS = try values.decodeIfPresent(String.self, forKey: .COMMENTS)
        ACTIVE_STATUS = try values.decodeIfPresent(String.self, forKey: .ACTIVE_STATUS)
        SOURCE = try values.decodeIfPresent(String.self, forKey: .SOURCE)
        CREATED_DATE = try values.decodeIfPresent(String.self, forKey: .CREATED_DATE)
        CREATED_BY = try values.decodeIfPresent(String.self, forKey: .CREATED_BY)
        CHANGED_DATE = try values.decodeIfPresent(String.self, forKey: .CHANGED_DATE)
        CHANGED_BY = try values.decodeIfPresent(String.self, forKey: .CHANGED_BY)
        SORT_ORDER = try values.decodeIfPresent(Double.self, forKey: .SORT_ORDER)
        CO_CODE = try values.decodeIfPresent(String.self, forKey: .CO_CODE)
        ATTRIBUTE1 = try values.decodeIfPresent(String.self, forKey: .ATTRIBUTE1)
        ATTRIBUTE2 = try values.decodeIfPresent(String.self, forKey: .ATTRIBUTE2)
        ATTRIBUTE3 = try values.decodeIfPresent(String.self, forKey: .ATTRIBUTE3)
        COMMENTS2 = try values.decodeIfPresent(String.self, forKey: .COMMENTS2)
        FRENCH_DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .FRENCH_DESCRIPTION)
        SPANISH_DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .SPANISH_DESCRIPTION)
        IS_SUMMARY = try values.decodeIfPresent(Bool.self, forKey: .IS_SUMMARY)
        Paid = try values.decodeIfPresent(Bool.self, forKey: .Paid)
        ExportItem = try values.decodeIfPresent(Bool.self, forKey: .ExportItem)
        DynamicProperties = try values.decodeIfPresent([String].self, forKey: .DynamicProperties)
        IS_DELETED = try values.decodeIfPresent(String.self, forKey: .IS_DELETED)
        HISTORY_LINK = try values.decodeIfPresent(String.self, forKey: .HISTORY_LINK)
        History = try values.decodeIfPresent([String].self, forKey: .History)
        EditColumnBool = try values.decodeIfPresent(Bool.self, forKey: .EditColumnBool)
        ReadOnlyBool = try values.decodeIfPresent(Bool.self, forKey: .ReadOnlyBool)
        HistoryColumnsOverride = try values.decodeIfPresent(String.self, forKey: .HistoryColumnsOverride)
    }

    init(_ model: AAI_TABLE_COLUMN_REF_CORE) {
        TABLE_NAME = model.table_name
        COLUMN_NAME = model.column_name
        COLUMN_VALUE = model.column_value
        DESCRIPTION = model.desc
        COMMENTS = model.comments
        ACTIVE_STATUS = model.active_status
        SOURCE = model.source
        CREATED_DATE = model.created_date
        CREATED_BY = model.created_by
        CHANGED_DATE = model.changed_date
        CHANGED_BY = model.changed_by
        SORT_ORDER = Double(model.sort_order)
        CO_CODE = model.co_code
        ATTRIBUTE1 = model.attribute1
        ATTRIBUTE2 = model.attribute2
        ATTRIBUTE3 = model.attribute3
        COMMENTS2 = model.comments2
        FRENCH_DESCRIPTION = model.french_description
        SPANISH_DESCRIPTION = model.spanish_description

        IS_SUMMARY = nil
        Paid = nil
        ExportItem = nil
        DynamicProperties = nil
        IS_DELETED = nil
        HISTORY_LINK = nil
        History = nil
        EditColumnBool = nil
        ReadOnlyBool = nil
        HistoryColumnsOverride = nil
    }

}
/*
    init(_ model: AAI_TABLE_COLUMN_REF_CORE) {
        TABLE_NAME = model.table_name
        COLUMN_NAME = model.column_name
        COLUMN_VALUE = model.column_value
        DESCRIPTION = model.desc
        COMMENTS = model.comments
        ACTIVE_STATUS = model.active_status
        SOURCE = model.source
        CREATED_DATE = model.created_date
        CREATED_BY = model.created_by
        CHANGED_DATE = model.changed_date
        CHANGED_BY = model.changed_by
        SORT_ORDER = Int(model.sort_order)
        CO_CODE = model.co_code
        ATTRIBUTE1 = model.attribute1
        ATTRIBUTE2 = model.attribute2
        ATTRIBUTE3 = model.attribute3
        COMMENTS2 = model.comments2
        FRENCH_DESCRIPTION = model.french_description
        SPANISH_DESCRIPTION = model.spanish_description
    }
}
 */
