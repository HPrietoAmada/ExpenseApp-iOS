//
//  LocationHelper.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/27/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
// import MapboxDirections

let locationCache = NSCache<AnyObject, AnyObject>()

extension GMSAutocompleteViewController {
    func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}

extension CLLocationCoordinate2D {

    func getPlaceName(completionHandler: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        let locationCacheKey = "\(self.latitude)\(self.longitude)"
        if let cachedPlace = locationCache.object(forKey: locationCacheKey as AnyObject) as? CLPlacemark {
            completionHandler(cachedPlace)
            return
        }
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)

        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location,
                                        completionHandler: { (placemarks, error) in
                                            if let _ = error {
                                                // An error occurred during geocoding.
                                                completionHandler(nil)
                                                return
                                            }

                                            if let placemark = placemarks?.first {
                                                let locationIsNotCached = locationCache.object(forKey: locationCacheKey as AnyObject) == nil
                                                let coordinateIsValid = placemark.location?.coordinate.latitude != 0.0 && placemark.location?.coordinate.latitude != 0.0
                                                if locationIsNotCached && coordinateIsValid {
                                                    locationCache.setObject(placemark, forKey: locationCacheKey as AnyObject)
                                                    completionHandler(placemark)
                                                }
                                            }
        })
    }

    func miles(to: CLLocationCoordinate2D, uom: String = "MI") -> Double {
        let originLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let destinationLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return originLocation.miles(from: destinationLocation, uom: uom)
    }
}

extension GMSPlace {

    func miles(to: GMSPlace, uom: String = "MI") -> Double {
        let originLocation = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        let destinationLocation = CLLocation(latitude: to.coordinate.latitude, longitude: to.coordinate.longitude)
        return originLocation.miles(from: destinationLocation, uom: uom)
    }
}

extension CLLocation {

    func miles(from: CLLocation, uom: String = "MI") -> Double {
        return uom.uppercased().contains("MI") ? distance(from:from) * 0.000621371 : distance(from: from) * 0.001
    }

    func getPlaceName(completionHandler: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        let locationCacheKey = "\(self.coordinate.latitude)\(self.coordinate.longitude)"
        if let cachedPlace = locationCache.object(forKey: locationCacheKey as AnyObject) as? CLPlacemark {
            completionHandler(cachedPlace)
            return
        }

        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self,
                                        completionHandler: { (placemarks, error) in
                                            if let _ = error {
                                                // An error occurred during geocoding.
                                                completionHandler(nil)
                                                return
                                            }

                                            if let placemark = placemarks?.first {
                                                let locationIsNotCached = locationCache.object(forKey: locationCacheKey as AnyObject) == nil
                                                let coordinateIsValid = placemark.location?.coordinate.latitude != 0.0 && placemark.location?.coordinate.latitude != 0.0
                                                if locationIsNotCached && coordinateIsValid {
                                                    locationCache.setObject(placemark, forKey: locationCacheKey as AnyObject)
                                                    completionHandler(placemark)
                                                }
                                            }
        })
    }
}
