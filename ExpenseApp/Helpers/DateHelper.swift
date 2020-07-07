//
//  DateHelper.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/27/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension Date {

    func toString(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func getFormattedDate(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func toDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

extension TimeInterval {

    func getFormattedDate(format: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}

extension String {

    func toDateTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

    func toDate(_ format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

    func getDate(_ format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar.current
        return dateFormatter.date(from: self)
    }

}
