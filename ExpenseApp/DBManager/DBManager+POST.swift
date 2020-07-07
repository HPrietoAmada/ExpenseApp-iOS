//
//  DBManager+POST.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/16/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension DBManager {

    func post<T>(_ model: T, path: String, _ completionHandler: StatusReturned? = nil) {
        guard let encodable = model as? Encodable else {
            completionHandler?(
                NSError(
                    domain: "",
                    code: 400,
                    userInfo: [NSLocalizedDescriptionKey: "Encodable object required"]
                )
            )
            return
        }
        do {
            let data = try encodable.toJSON()
            guard let json = String(data: data, encoding: .utf8) else {
                completionHandler?(
                    NSError(
                        domain:"",
                        code:400,
                        userInfo:[ NSLocalizedDescriptionKey: "Unable to serialize object"]
                    )
                )
                return
            }
            print("POST: \(json)")
            guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiUrl)\(path)") else {
                    completionHandler?(
                        NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "API not found"])
                    )
                    return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json.data(using: .utf8)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
        } catch let error {
            DispatchQueue.main.async {
                completionHandler?(error.toNSError())
            }
        }
    }

}
