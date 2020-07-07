//
//  DBManager+EXP_HDR.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // POST: api/trip
    func createTrip(model: EXP_HDR, _ completionHandler: StatusReturned? = nil) {
        post(model, path: "trip", completionHandler)
    }

    // PUT: api/trip
    func updateTrip(model: EXP_HDR, _ completionHandler: StatusReturned? = nil) {
        put(model, path: "trip", completionHandler)
    }

    // PUT: api/trip/{id}/username/{username}/notes/{notes}
    func sendTripNotes(id: Int, username: String, notes: String, _ completionHandler: StatusReturned? = nil) {
        //let path: String = "trip/\(id)/username/\(username)/notes/\(notes)"
        let path: String = "trip/notes"
        let body: [String: Any] = [
            "id": id,
            "changed_by": username,
            "notes": notes
        ]
        put(path, body: body, completionHandler)
    }

    // PUT: api/trip/{id}/approve/by/{username}/department/{department}
    func approveTrip(id: Int, username: String, department: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)/approve/\(username)/department/\(department)"
        put(path, completionHandler)
    }

    // PUT: api/trip/{id}/reject/by/{username}/department/{department}/reason/{reason}
    func rejectTrip(id: Int, username: String, department: String, reason: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)/reject/\(username)/department/\(department)/reason/\(reason)"
        put(path, completionHandler)
    }

    // PUT: api/trip/{id}/status/{status}/by/{username}
    func statusTrip(id: Int, username: String, status: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)/status/\(status)/by/\(username)"
        put(path, completionHandler)
    }

    // PUT: api/trip/{id}/submit/{status}/by/{username}
    func submitTrip(id: Int, username: String, status: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)/submit/\(status)/by/\(username)"
        put(path, completionHandler)
    }

    // DELETE: api/trip/{id}
    func deleteTrip(id: Int, _ completionHandler: StatusReturned? = nil) {
        let path: String = "trip/\(id)"
        delete(path, completionHandler)
    }

    // GET: api/trip/{id}
    func getTripModel(id: Int, _ completionHandler: @escaping DataReturned<TripModel>) {
        let path: String = "trip/\(id)/model"
        get(path, completionHandler)
    }
}
