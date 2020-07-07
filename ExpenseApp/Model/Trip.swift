//
//  Trip.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/10/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation
// import MapboxDirections

class Trip {
    let startCoordinate: CLLocationCoordinate2D?
    let endCoordinate: CLLocationCoordinate2D?
    let startTime: Double?
    let endTime: Double?
    let odomStart: Int?
    let odomEnd: Int?

    /// Trip Class Contructor
    ///
    /// - Parameters:
    ///   - startLocation: The coordinate of the START of the trip
    ///   - endLocation: The coordinate of the END of the trip
    ///   - startTime: Timestamp from the START of the trip
    ///   - endTime: Timestamp from the END of the trip
    init(startCoordinate: CLLocationCoordinate2D,
         endCoordinate: CLLocationCoordinate2D,
         startTime: Double,
         endTime: Double,
         odomStart: Int)
    {
        self.startCoordinate = startCoordinate
        self.endCoordinate = endCoordinate
        self.startTime = startTime
        self.endTime = endTime
        self.odomStart = odomStart

        let startLocation = CLLocation(latitude: startCoordinate.latitude,
                                       longitude: startCoordinate.longitude)

        let endLocation = CLLocation(latitude: endCoordinate.latitude,
                                     longitude: endCoordinate.longitude)

        self.odomEnd = odomStart + Int(CGFloat(startLocation.distance(from: endLocation) / 1609))
    }

    /// Returns the distnace of the trip in miles if available
    ///
    /// - Returns: A Float value representing the distnace in miles
    ///   of the trip
    func getTripMiles() -> CGFloat?
    {
        guard let startCoordinate = self.startCoordinate,
            let endCoordinate = self.endCoordinate else {
                return nil
        }

        let startLocation = CLLocation(latitude: startCoordinate.latitude,
                                       longitude: startCoordinate.longitude)

        let endLocation = CLLocation(latitude: endCoordinate.latitude,
                                     longitude: endCoordinate.longitude)

        return CGFloat(startLocation.distance(from: endLocation) / 1609)
    }

    func getStartDate() -> Date?
    {
        guard let startTime = startTime else {
            return nil
        }

        return Date(timeIntervalSince1970: startTime)
    }

    func getStartDateString() -> String?
    {
        guard let startTime = startTime else {
            return nil
        }

        let date = Date(timeIntervalSince1970: startTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func getStartTimeString() -> String?
    {
        guard let startTime = startTime else {
            return nil
        }

        let date = Date(timeIntervalSince1970: startTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }

    func getEndDate() -> Date?
    {
        guard let endTime = endTime else {
            return nil
        }
        
        return Date(timeIntervalSince1970: endTime)
    }

    func getEndDateString() -> String?
    {
        guard let endTime = endTime else {
            return nil
        }

        let date = Date(timeIntervalSince1970: endTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func getEndTimeString() -> String?
    {
        guard let endTime = endTime else {
            return nil
        }

        let date = Date(timeIntervalSince1970: endTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }
    /*
    func getStartPlace() -> Waypoint?
    {
        guard let startCoordinate = startCoordinate else {
            return nil
        }

        return Waypoint(coordinate: startCoordinate)
    }

    func getEndPlace() -> Waypoint?
    {
        guard let endCoordinate = endCoordinate else {
            return nil
        }

        return Waypoint(coordinate: endCoordinate)
    }*/
}
