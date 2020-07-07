//
//  DBManager+ManagerExpenseModel.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/9/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // GET: api/trip/manager/{id}/employees
    func getManagerEmployeeTripModels(id: Int,_ completionHandler: @escaping DataReturned<[ManagerExpenseModel]>) {
        let path: String = "trip/manager/\(id)/employees"
        get(path, completionHandler)
    }
}
