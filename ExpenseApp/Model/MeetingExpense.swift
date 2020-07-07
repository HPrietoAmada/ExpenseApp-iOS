//
//  MeetingExpense.swift
//  AmadaTimeOff
//
//  Created by IT Support on 5/31/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation

class MeetingExpense {
    var startDate: Date?
    var endDate: Date?
    var purpose: String?
    var employee: String?
    var location: CLLocationCoordinate2D?
    var timestamp: Double?
    var type: Int?

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
