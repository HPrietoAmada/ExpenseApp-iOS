//
//  DBManager+DELETE.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/16/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension DBManager {

    func delete(_ path: String, _ completionHandler: StatusReturned? = nil) {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
            let url = URL(string: "\(apiUrl)\(path)") else {
                completionHandler?(
                    NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "API not found"])
                )
                return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler?(error.toNSError())
                }
                if let response = response as? HTTPURLResponse {
                    completionHandler?(
                        NSError(
                            domain: "",
                            code: response.statusCode,
                            userInfo: [NSLocalizedDescriptionKey: response.description]
                    ))
                }
            }
        }
        task.resume()
    }
}
