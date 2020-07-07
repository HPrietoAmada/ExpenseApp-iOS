//
//  DBManager+EXP_DTL_GUESTS.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/10/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    func createGuests(_ models: [EXP_DTL_GUESTS], _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense/guests"
        post(models, path: path, completionHandler)
    }

    func deleteGuest(_ id: Int, _ completionHandler: StatusReturned?) {
        let path: String = "expense/guests/\(id)"
        delete(path, completionHandler)
    }

    func deleteExpenseGuests(_ id: Int, _ completionHandler: StatusReturned? = nil) {
        let path: String = "expense/\(id)/guests"
        delete(path, completionHandler)
    }

    func deleteTripGuests(_ id: Int, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)/guests"
        delete(path, completionHandler)
    }

    func getExpenseGuests(_ id: Int, _ completionHandler: @escaping DataReturned<[EXP_DTL_GUESTS]>) {
        let path: String = "expense/{id}/guests"
        get(path, completionHandler)
    }

    func getTripGuests(_ id: Int, _ completionHandler: @escaping DataReturned<[EXP_DTL_GUESTS]>) {
        let path: String = "trip/\(id)/guests"
        get(path, completionHandler)
    }

}
