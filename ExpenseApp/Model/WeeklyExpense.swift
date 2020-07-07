//
//  WeeklyExpense.swift
//  AmadaTimeOff
//
//  Created by IT Support on 5/31/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation

class WeeklyExpense {
    var odomStart: Double?
    var odomEnd: Double?
    var startDate: Date?
    var endDate: Date?
    var gasRate: Double?
    var employee: Int?
    var location: CLLocationCoordinate2D?
    var timestamp: Double?
    var breakfastIncluded: Bool?
    var purpose: String?

    /* Returns the total amount spend on miles traveled/driven */
    func getTotalExpense() -> Double? {
        guard let start = self.odomStart,
            let end = self.odomEnd,
            let rate = self.gasRate else {
                return nil
        }
        return (end - start) * rate
    }

    /* Returns the total miles travelled */
    func getTotalMiles() -> Double? {
        guard let start = self.odomStart,
            let end = self.odomEnd else {
                return nil
        }
        return end - start
    }

    /* Returns the START and END dates formatted */
    func getFormattedDateRange() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"

        // User hasn't chosen a start or end date
        if self.startDate == nil && self.endDate == nil {
            return "No Date Selected"

            // User only chose a start date
        } else if self.startDate != nil && self.endDate == nil {
            return "\(dateFormatter.string(from: self.startDate!))"

            // User chose both a start and end date
        } else {

            // Check if both dates are the same
            if self.startDate == self.endDate {
                return "\(dateFormatter.string(from: self.startDate!))"

            } else {
                return "\(dateFormatter.string(from: self.startDate!)) - \(dateFormatter.string(from: self.endDate!))"
            }
        }
    }

    convenience init(data: [String: AnyObject]) {
        self.init()
    }
}
