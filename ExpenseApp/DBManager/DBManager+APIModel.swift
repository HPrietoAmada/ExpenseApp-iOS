//
//  DBManager+APIModel.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 4/9/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation

extension DBManager {
    // GET: api/uid/{uid}
    func getAPIModel(uid: Int, _ completionHandler: @escaping DataReturned<APIModel>) {
        let path: String = "uid/\(uid)"
        get(path, completionHandler)
    }
}
