//
//  DBManager+ExpenseModel.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/8/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // POST: api/trip/models
    func createTripModels(models: [TripModel], _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/models"
        put(models, path: path, completionHandler)
    }

    // POST: api/trip/model
    func createTripModel(model: TripModel, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/model"
        post(model, path: path, completionHandler)
    }

    // GET: api/trip/model/username/{username}/status/{status}
    func getUserTrips(
        username: String,
        status: String = "OPEN",
        _ completionHandler: @escaping DataReturned<[TripModel]>) {
        let path: String = "trip/model/username/\(username)/status/\(status)"
        get(path, completionHandler)
    }

    // GET: api/trip/model/userid/{userid}
    func getUserTripModels(
        user_id: Int,
        _ completionHandler: @escaping DataReturned<[TripModel]>) {
        let path: String = "trip/model/userid/\(user_id)"
        get(path, completionHandler)
    }
}
