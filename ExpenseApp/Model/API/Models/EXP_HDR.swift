//
//  EXP_HDR.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

struct EXP_HDR: Codable {
     var NAME_FIRST : String?
       var NAME_LAST : String?
       var DISPLAY_NAME : String?
       var USERNAME : String?
       var ID : Int?
       var CO_CODE : String?
       var USER_ID : Int?
       var EMP_ID : Int?
       var EMP_VENDOR_NUM : String?
       var BEG_DATE : String?
       var END_DATE : String?
       var EXP_STATUS : String?
       var TRIP_TYPE : String?
       var TRIP_NAME : String?
       var PURPOSE : String?
       var CASH_ON_HAND : Double?
       var CASH_ADVANCED : Double?
       var PR_ID : Double?
       var AWA_NUMBER : String?
       var COST_CENTER : String?
       var PROFIT_CENTER : String?
       var REQUESTED_DATE : String?
       var REQUESTED_BY : String?
       var SUBMITTED_DATE : String?
       var SUBMITTED_BY : String?
       var MGR_APPROVED_DATE : String?
       var MGR_APPROVED_BY : String?
       var MGR_REJECTED_REASON : String?
       var MGR_REJECTED_DATE : String?
       var MGR_REJECTED_BY : String?
       var CREATED_DATE : String?
       var CREATED_BY : String?
       var CHANGED_DATE : String?
       var CHANGED_BY : String?
       var NOTES : String?
       var ACC_APPROVED_DATE : String?
       var ACC_APPROVED_BY : String?
       var ACC_REJECTED_REASON : String?
       var ACC_REJECTED_DATE : String?
       var ACC_REJECTED_BY : String?
       var TRIP_TYPE_DESCRIPTION : String?
       var STATUS_DESCRIPTION : String?
       var BEG_DATE_STR : String?
       var END_DATE_STR : String?
       var BEG_DATE_FORMATTED : String?
       var END_DATE_FORMATTED : String?
       var SUBMITTED_DATE_FORMATTED : String?
       var MGR_APPROVED_DATE_FORMATTED : String?
       var ACC_APPROVED_DATE_FORMATTED : String?
       var CREATED_DATE_FORMATTED : String?
       var CHANGED_DATE_FORMATTED : String?
       var TRIP_TOTAL : Double?
       var REPORTS_TO : Double?
       var REPORTS_TO_USERNAME : String?
       var IS_SUMMARY : Bool?
       var Paid : Bool?
       var ExportItem : Bool?
       var DynamicProperties : [String]?
       var IS_DELETED : String?
       var HISTORY_LINK : String?
       var History : [String]?
       var EditColumnBool : Bool?
       var ReadOnlyBool : Bool?
       var HistoryColumnsOverride : String?

       enum CodingKeys: String, CodingKey {

           case NAME_FIRST = "NAME_FIRST"
           case NAME_LAST = "NAME_LAST"
           case DISPLAY_NAME = "DISPLAY_NAME"
           case USERNAME = "USERNAME"
           case ID = "ID"
           case CO_CODE = "CO_CODE"
           case USER_ID = "USER_ID"
           case EMP_ID = "EMP_ID"
           case EMP_VENDOR_NUM = "EMP_VENDOR_NUM"
           case BEG_DATE = "BEG_DATE"
           case END_DATE = "END_DATE"
           case EXP_STATUS = "EXP_STATUS"
           case TRIP_TYPE = "TRIP_TYPE"
           case TRIP_NAME = "TRIP_NAME"
           case PURPOSE = "PURPOSE"
           case CASH_ON_HAND = "CASH_ON_HAND"
           case CASH_ADVANCED = "CASH_ADVANCED"
           case PR_ID = "PR_ID"
           case AWA_NUMBER = "AWA_NUMBER"
           case COST_CENTER = "COST_CENTER"
           case PROFIT_CENTER = "PROFIT_CENTER"
           case REQUESTED_DATE = "REQUESTED_DATE"
           case REQUESTED_BY = "REQUESTED_BY"
           case SUBMITTED_DATE = "SUBMITTED_DATE"
           case SUBMITTED_BY = "SUBMITTED_BY"
           case MGR_APPROVED_DATE = "MGR_APPROVED_DATE"
           case MGR_APPROVED_BY = "MGR_APPROVED_BY"
           case MGR_REJECTED_REASON = "MGR_REJECTED_REASON"
           case MGR_REJECTED_DATE = "MGR_REJECTED_DATE"
           case MGR_REJECTED_BY = "MGR_REJECTED_BY"
           case CREATED_DATE = "CREATED_DATE"
           case CREATED_BY = "CREATED_BY"
           case CHANGED_DATE = "CHANGED_DATE"
           case CHANGED_BY = "CHANGED_BY"
           case NOTES = "NOTES"
           case ACC_APPROVED_DATE = "ACC_APPROVED_DATE"
           case ACC_APPROVED_BY = "ACC_APPROVED_BY"
           case ACC_REJECTED_REASON = "ACC_REJECTED_REASON"
           case ACC_REJECTED_DATE = "ACC_REJECTED_DATE"
           case ACC_REJECTED_BY = "ACC_REJECTED_BY"
           case TRIP_TYPE_DESCRIPTION = "TRIP_TYPE_DESCRIPTION"
           case STATUS_DESCRIPTION = "STATUS_DESCRIPTION"
           case BEG_DATE_STR = "BEG_DATE_STR"
           case END_DATE_STR = "END_DATE_STR"
           case BEG_DATE_FORMATTED = "BEG_DATE_FORMATTED"
           case END_DATE_FORMATTED = "END_DATE_FORMATTED"
           case SUBMITTED_DATE_FORMATTED = "SUBMITTED_DATE_FORMATTED"
           case MGR_APPROVED_DATE_FORMATTED = "MGR_APPROVED_DATE_FORMATTED"
           case ACC_APPROVED_DATE_FORMATTED = "ACC_APPROVED_DATE_FORMATTED"
           case CREATED_DATE_FORMATTED = "CREATED_DATE_FORMATTED"
           case CHANGED_DATE_FORMATTED = "CHANGED_DATE_FORMATTED"
           case TRIP_TOTAL = "TRIP_TOTAL"
           case REPORTS_TO = "REPORTS_TO"
           case REPORTS_TO_USERNAME = "REPORTS_TO_USERNAME"
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
           NAME_FIRST = try values.decodeIfPresent(String.self, forKey: .NAME_FIRST)
           NAME_LAST = try values.decodeIfPresent(String.self, forKey: .NAME_LAST)
           DISPLAY_NAME = try values.decodeIfPresent(String.self, forKey: .DISPLAY_NAME)
           USERNAME = try values.decodeIfPresent(String.self, forKey: .USERNAME)
           ID = try values.decodeIfPresent(Int.self, forKey: .ID)
           CO_CODE = try values.decodeIfPresent(String.self, forKey: .CO_CODE)
           USER_ID = try values.decodeIfPresent(Int.self, forKey: .USER_ID)
           EMP_ID = try values.decodeIfPresent(Int.self, forKey: .EMP_ID)
           EMP_VENDOR_NUM = try values.decodeIfPresent(String.self, forKey: .EMP_VENDOR_NUM)
           BEG_DATE = try values.decodeIfPresent(String.self, forKey: .BEG_DATE)
           END_DATE = try values.decodeIfPresent(String.self, forKey: .END_DATE)
           EXP_STATUS = try values.decodeIfPresent(String.self, forKey: .EXP_STATUS)
           TRIP_TYPE = try values.decodeIfPresent(String.self, forKey: .TRIP_TYPE)
           TRIP_NAME = try values.decodeIfPresent(String.self, forKey: .TRIP_NAME)
           PURPOSE = try values.decodeIfPresent(String.self, forKey: .PURPOSE)
           CASH_ON_HAND = try values.decodeIfPresent(Double.self, forKey: .CASH_ON_HAND)
           CASH_ADVANCED = try values.decodeIfPresent(Double.self, forKey: .CASH_ADVANCED)
           PR_ID = try values.decodeIfPresent(Double.self, forKey: .PR_ID)
           AWA_NUMBER = try values.decodeIfPresent(String.self, forKey: .AWA_NUMBER)
           COST_CENTER = try values.decodeIfPresent(String.self, forKey: .COST_CENTER)
           PROFIT_CENTER = try values.decodeIfPresent(String.self, forKey: .PROFIT_CENTER)
           REQUESTED_DATE = try values.decodeIfPresent(String.self, forKey: .REQUESTED_DATE)
           REQUESTED_BY = try values.decodeIfPresent(String.self, forKey: .REQUESTED_BY)
           SUBMITTED_DATE = try values.decodeIfPresent(String.self, forKey: .SUBMITTED_DATE)
           SUBMITTED_BY = try values.decodeIfPresent(String.self, forKey: .SUBMITTED_BY)
           MGR_APPROVED_DATE = try values.decodeIfPresent(String.self, forKey: .MGR_APPROVED_DATE)
           MGR_APPROVED_BY = try values.decodeIfPresent(String.self, forKey: .MGR_APPROVED_BY)
           MGR_REJECTED_REASON = try values.decodeIfPresent(String.self, forKey: .MGR_REJECTED_REASON)
           MGR_REJECTED_DATE = try values.decodeIfPresent(String.self, forKey: .MGR_REJECTED_DATE)
           MGR_REJECTED_BY = try values.decodeIfPresent(String.self, forKey: .MGR_REJECTED_BY)
           CREATED_DATE = try values.decodeIfPresent(String.self, forKey: .CREATED_DATE)
           CREATED_BY = try values.decodeIfPresent(String.self, forKey: .CREATED_BY)
           CHANGED_DATE = try values.decodeIfPresent(String.self, forKey: .CHANGED_DATE)
           CHANGED_BY = try values.decodeIfPresent(String.self, forKey: .CHANGED_BY)
           NOTES = try values.decodeIfPresent(String.self, forKey: .NOTES)
           ACC_APPROVED_DATE = try values.decodeIfPresent(String.self, forKey: .ACC_APPROVED_DATE)
           ACC_APPROVED_BY = try values.decodeIfPresent(String.self, forKey: .ACC_APPROVED_BY)
           ACC_REJECTED_REASON = try values.decodeIfPresent(String.self, forKey: .ACC_REJECTED_REASON)
           ACC_REJECTED_DATE = try values.decodeIfPresent(String.self, forKey: .ACC_REJECTED_DATE)
           ACC_REJECTED_BY = try values.decodeIfPresent(String.self, forKey: .ACC_REJECTED_BY)
           TRIP_TYPE_DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .TRIP_TYPE_DESCRIPTION)
           STATUS_DESCRIPTION = try values.decodeIfPresent(String.self, forKey: .STATUS_DESCRIPTION)
           BEG_DATE_STR = try values.decodeIfPresent(String.self, forKey: .BEG_DATE_STR)
           END_DATE_STR = try values.decodeIfPresent(String.self, forKey: .END_DATE_STR)
           BEG_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .BEG_DATE_FORMATTED)
           END_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .END_DATE_FORMATTED)
           SUBMITTED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .SUBMITTED_DATE_FORMATTED)
           MGR_APPROVED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .MGR_APPROVED_DATE_FORMATTED)
           ACC_APPROVED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .ACC_APPROVED_DATE_FORMATTED)
           CREATED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .CREATED_DATE_FORMATTED)
           CHANGED_DATE_FORMATTED = try values.decodeIfPresent(String.self, forKey: .CHANGED_DATE_FORMATTED)
           TRIP_TOTAL = try values.decodeIfPresent(Double.self, forKey: .TRIP_TOTAL)
           REPORTS_TO = try values.decodeIfPresent(Double.self, forKey: .REPORTS_TO)
           REPORTS_TO_USERNAME = try values.decodeIfPresent(String.self, forKey: .REPORTS_TO_USERNAME)
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

       init(_ model: EXP_HDR_CORE) {
           NAME_FIRST = nil
           NAME_LAST = nil
           DISPLAY_NAME = nil
           USERNAME = nil

           ID = Int(model.id)
           CO_CODE = model.co_code
           USER_ID = Int(model.user_id)
           EMP_ID = Int(model.emp_id)
           EMP_VENDOR_NUM = model.emp_vendor_num
           BEG_DATE = model.beg_date
           END_DATE = model.end_date
           EXP_STATUS = model.exp_status
           TRIP_TYPE = model.trip_type
           TRIP_NAME = model.trip_name
           PURPOSE = model.purpose
           CASH_ON_HAND = model.cash_on_hand
           CASH_ADVANCED = model.cash_advanced
           PR_ID = Double(model.pr_id)
           AWA_NUMBER = model.awa_number
           COST_CENTER = model.cost_center
           PROFIT_CENTER = model.profit_center
           REQUESTED_BY = model.requested_by
           REQUESTED_DATE = model.requested_date
           SUBMITTED_DATE = model.submitted_date
           SUBMITTED_BY = model.submitted_by
           MGR_APPROVED_DATE = model.mgr_approved_date
           MGR_APPROVED_BY = model.mgr_approved_by
           MGR_REJECTED_REASON = model.mgr_rejected_reason
           MGR_REJECTED_DATE = model.mgr_rejected_date
           MGR_REJECTED_BY = model.mgr_rejected_by
           CREATED_DATE = model.created_date
           CREATED_BY = model.created_by
           CHANGED_DATE = model.changed_date
           CHANGED_BY = model.changed_by
           NOTES = model.notes
           ACC_APPROVED_BY = model.acc_approved_by
           ACC_APPROVED_DATE = model.acc_approved_date
           ACC_REJECTED_REASON = model.acc_rejected_reason
           ACC_REJECTED_DATE = model.acc_rejected_date
           ACC_REJECTED_BY = model.acc_rejected_by

           TRIP_TYPE_DESCRIPTION = nil
           STATUS_DESCRIPTION = nil
           BEG_DATE_STR = nil
           END_DATE_STR = nil
           BEG_DATE_FORMATTED = nil
           END_DATE_FORMATTED = nil
           SUBMITTED_DATE_FORMATTED = nil
           MGR_APPROVED_DATE_FORMATTED = nil
           ACC_APPROVED_DATE_FORMATTED = nil
           CREATED_DATE_FORMATTED = nil
           CHANGED_DATE_FORMATTED = nil
           TRIP_TOTAL = nil
           REPORTS_TO = nil
           REPORTS_TO_USERNAME = nil
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

    init() {
        NAME_FIRST = nil
        NAME_LAST = nil
        DISPLAY_NAME = nil
        USERNAME = nil
        ID = 0
        CO_CODE = ""
        USER_ID = 0
        EMP_ID = 0
        EMP_VENDOR_NUM = ""
        BEG_DATE = ""
        END_DATE = ""
        EXP_STATUS = ""
        TRIP_TYPE = ""
        TRIP_NAME = ""
        PURPOSE = ""
        CASH_ON_HAND = 0.0
        CASH_ADVANCED = 0.0
        PR_ID = 0
        AWA_NUMBER = ""
        COST_CENTER = ""
        PROFIT_CENTER = ""
        REQUESTED_BY = ""
        REQUESTED_DATE = Date().toDateTime()
        SUBMITTED_DATE = Date().toDateTime()
        SUBMITTED_BY = ""
        MGR_APPROVED_DATE = Date().toDateTime()
        MGR_APPROVED_BY = ""
        MGR_REJECTED_REASON = ""
        MGR_REJECTED_DATE = Date().toDateTime()
        MGR_REJECTED_BY = ""
        CREATED_DATE = Date().toDateTime()
        CREATED_BY = ""
        CHANGED_DATE = Date().toDateTime()
        CHANGED_BY = ""
        NOTES = ""
        ACC_APPROVED_BY = ""
        ACC_APPROVED_DATE = Date().toDateTime()
        ACC_REJECTED_REASON = ""
        ACC_REJECTED_DATE = Date().toDateTime()
        ACC_REJECTED_BY = ""
        TRIP_TYPE_DESCRIPTION = nil
        STATUS_DESCRIPTION = nil
        BEG_DATE_STR = nil
        END_DATE_STR = nil
        BEG_DATE_FORMATTED = nil
        END_DATE_FORMATTED = nil
        SUBMITTED_DATE_FORMATTED = nil
        MGR_APPROVED_DATE_FORMATTED = nil
        ACC_APPROVED_DATE_FORMATTED = nil
        CREATED_DATE_FORMATTED = nil
        CHANGED_DATE_FORMATTED = nil
        TRIP_TOTAL = nil
        REPORTS_TO = nil
        REPORTS_TO_USERNAME = nil
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
