//
//  MileageExpense.swift
//  AmadaTimeOff
//
//  Created by Heriberto Prieto on 1/16/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import CoreData

class MileageExpense: NSManagedObject {
    var odomStart: Int?
    var odomEnd: Int?
    var startDate: Date?
    var endDate: Date?
    var purpose: String?
    var gasRate: Double?
    var employee: Int?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var timestamp: Double?
    
    /* Returns the total amount spent on miles traveled/driven */
    func getTotalExpense() -> Double? {
        guard let start = self.odomStart,
            let end = self.odomEnd,
            let rate = self.gasRate else {
                return nil
        }
        return Double(end - start) * rate
    }
    
    /* Returns the total miles travelled */
    func getTotalMiles() -> Double? {
        guard let start = self.odomStart,
            let end = self.odomEnd else {
                return nil
        }
        return Double(end - start)
    }

    /* Returns the START and END dates in a formatted string */
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

            // Check if both start and end dates are the same
            if self.startDate == self.endDate {
                return "\(dateFormatter.string(from: self.startDate!))"
            } else {
                return "\(dateFormatter.string(from: self.startDate!)) - \(dateFormatter.string(from: self.endDate!))"
            }
        }
    }

    /* Returns the number of days */
    func getNumberOfDays() -> Int {
        guard let startDate = self.startDate else {
            return 0
        }

        guard let endDate = self.endDate else {
            return 1
        }

        guard let numberOfDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day else {
            return 1
        }

        return numberOfDays
    }

    /* Returns an array of Date objects starting from StartDate to EndDate */
    func getDaysBetween() -> [Date] {
        var daysBetween = [Date]()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"

        // User has not chosen a start date
        guard var indexDate = self.startDate else {
            return []
        }

        // User chose a start date but not an end date
        guard let endDate = self.endDate else {
            return [indexDate]
        }

        // Gets all dates between start and end date
        while indexDate <= endDate {
            daysBetween.append(indexDate)
            indexDate = Calendar.current.date(byAdding: .day, value: 1, to: indexDate)!
        }
        return daysBetween
    }

    /* Returns object properties in a string */
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"

        guard let odomStart = self.odomStart,
            let odomEnd = self.odomEnd,
            let startDate = self.startDate,
            let lat = self.latitude,
            let lon = self.longitude else {
                return ""
        }

        guard let endDate =  self.endDate else {
            return "[odomStart: \(odomStart), odomEnd: \(odomEnd), lat: \(lat), lon: \(lon), startDate: \(formatter.string(from: startDate))]"
        }
        return "[odomStart: \(odomStart), odomEnd: \(odomEnd), lat: \(lat), lon: \(lon), startDate: \(formatter.string(from: startDate)), endDate: \(formatter.string(from: endDate))]"
    }

    convenience init(data: [String: AnyObject]) {
        self.init()
    }
}

