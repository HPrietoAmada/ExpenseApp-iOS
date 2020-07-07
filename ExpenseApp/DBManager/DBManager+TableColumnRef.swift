//
//  DBManager+TableColumnRef.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/21/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // GET: api/tablecolref
    func getTableColRef(_ completionHandler: @escaping DataReturned<[AAI_TABLE_COLUMN_REF]>) {
        let path: String = "tablecolref"
        get(path, completionHandler)
    }

    // GET: api/tablecolref/column/{columnName}
    func getTableColRef(
        columnName: String,
        _ completionHandler: @escaping DataReturned<[AAI_TABLE_COLUMN_REF]>) {
        let path: String = "tablecolref/column/\(columnName)"
        get(path, completionHandler)
    }
}
