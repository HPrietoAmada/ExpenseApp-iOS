//
//  ExpenseSummary.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/20/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation
// import MapboxDirections

class ExpenseSummary {
    var firstname: String?
    var lastname: String?
    var email: String?
    var timestamp: Double?
    var latitude: Double?
    var longitude: Double?
    var amount: Double?

    init(firstname: String,
         lastname: String,
         email: String,
         timestamp: Double,
         latitude: Double,
         longitude: Double,
         amount: Double)
    {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.amount = amount
    }

    func getFullName() -> String? {
        guard let firstname = firstname,
            let lastname = lastname else {
                return nil
        }
        return "\(firstname) \(lastname)"
    }

    func getDollarAmountText() -> String? {
        guard let amount = amount else {
            return nil
        }
        return "$\(amount)"
    }

    /*
    func getExpensePlace() -> Waypoint? {
        guard let latitude = latitude,
            let longitude = longitude else {
                return nil
        }

        let coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                longitude: longitude)

        return Waypoint(coordinate: coordinate)
    }*/

    func getDateString() -> String?
    {
        guard let timestamp = timestamp else {
            return nil
        }

        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func getTimeString() -> String?
    {
        guard let timestamp = timestamp else {
            return nil
        }

        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }
}
