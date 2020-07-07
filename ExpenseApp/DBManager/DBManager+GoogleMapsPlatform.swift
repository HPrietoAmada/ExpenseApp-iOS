//
//  DBManager+GoogleMapsPlatform.swift
//  ExpenseApp
//
//  Created by IT Support on 6/10/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation
import MapKit
import UIKit

struct GMPDuration: Codable {
    public var value: Double?
    public var text: String?
}

struct GMPDistance: Codable {
    public var value: Double?
    public var text: String?

    func toMiles() -> Double {
        return (value ?? 0) * 0.000621371
    }
}

struct GMPFare: Codable {
    public var currency: String?
    public var value: Double?
    public var text: String?
}

struct GMPElement: Codable {
    public var distance: GMPDistance?
    public var duration: GMPDuration?
    public var status: String?
}

struct GMPRows: Codable {
    public var elements: [GMPElement] = [GMPElement]()
}

struct GMPObject: Codable {

    public var status: String?
    public var destination_addresses: [String] = [String]()
    public var origin_addresses: [String] = [String]()
    public var rows: [GMPRows] = [GMPRows]()
    
    func getDistance(inKM: Bool = false) -> Double? {
        guard let row = rows.first,
            let element = row.elements.first,
            let distance = element.distance else {
                return nil
        }

        return inKM ? distance.value : distance.toMiles()
    }
}

let distanceCache = NSCache<AnyObject, AnyObject>()

extension DBManager {
    func getDistance(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, _ completionHandler: @escaping (GMPObject?, Error?, String) -> Void) {

        let distanceCacheKey: String = "\(origin.latitude)-\(origin.longitude)-\(destination.latitude)-\(destination.longitude)"

        if let googleMapObject = distanceCache.object(forKey: distanceCacheKey as AnyObject) as? GMPObject {
            completionHandler(googleMapObject, nil, "success")
            return
        }

        guard let gcpKey = Bundle.main.object(forInfoDictionaryKey: "GMPKey") as? String,
            let distanceMatrix = Bundle.main.object(forInfoDictionaryKey: "distancematrix") as? String,
            let url: URL = URL(string: "\(distanceMatrix)origins=\(origin.latitude),\(origin.longitude)&destinations=\(destination.latitude),\(destination.longitude)&key=\(gcpKey)") else {
                completionHandler(nil,nil,"Unable to reach google maps servers.")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(nil, error, error.localizedDescription)
                    return
                }

                guard let data = data else {
                    completionHandler(nil,nil,"Unable to reach google maps servers.")
                    return
                }

                do {
                    let model = try JSONDecoder().decode(GMPObject.self, from: data)
                    distanceCache.setObject(model as AnyObject, forKey: distanceCacheKey as AnyObject)
                    completionHandler(model, nil, "success")
                } catch let err {
                    completionHandler(nil, err, err.localizedDescription)
                }
            }
        }
        task.resume()
    }

}
