//
//  DBManager+PUT.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/16/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension DBManager {


    func put(_ path: String, _ completionHandler: StatusReturned? = nil) {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
            let url = URL(string: "\(apiUrl)\(path)") else {
                completionHandler?(
                    NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "API not found"])
                )
                return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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

    func put<T>(_ model: T, path: String, _ completionHandler: StatusReturned? = nil) {
        do {
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
            let obj = try encodable.toJSON()
            guard let json = String(data: obj, encoding: .utf8) else {
                completionHandler?(
                    NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: "Unable to serialize object"])
                )
                return
            }
            guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiUrl)\(path)") else {
                    completionHandler?(
                        NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "API not found"])
                    )
                    return
            }
            print("PUT: \(json)")
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = json.data(using: .utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completionHandler?(error.toNSError())
                        return
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
        } catch let err {
            completionHandler?(err.toNSError())
        }
    }

    func put<T: Decodable>(_ model: T, path: String, _ completionHandler: @escaping (T?, NSError) -> Void) {
        do {
            guard let encodable = model as? Encodable else {
                completionHandler(
                    nil,
                    NSError(
                        domain: "dbmanager.put.model.datareturned",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: "Encodable object required"]
                    )
                )
                return
            }
            let obj = try encodable.toJSON()
            guard let json = String(data: obj, encoding: .utf8) else {
                completionHandler(
                    nil,
                    NSError(
                        domain:"dbmanager.put.model.datareturned",
                        code:400,
                        userInfo:[ NSLocalizedDescriptionKey: "Unable to serialize object"]
                    )
                )
                return
            }
            guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
                let url = URL(string: "\(apiUrl)\(path)") else {
                    completionHandler(
                        nil,
                        NSError(
                            domain: "dbmanager.put.model.datareturned",
                            code: 404,
                            userInfo: [NSLocalizedDescriptionKey: "API not found"]
                        )
                    )
                    return
            }
            print("PUT: \(json)")
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = json.data(using: .utf8)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    DispatchQueue.main.async {
                        if let error = error {
                            completionHandler(nil,error.toNSError())
                            return
                        }
                    }
                    return
                }
                do {
                    let models = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(
                            models,
                            NSError(
                                domain: "dbmanager.put.model.datareturned",
                                code: 200,
                                userInfo: [ NSLocalizedDescriptionKey: "success" ]
                            )
                        )
                    }
                } catch let err {
                    DispatchQueue.main.async {
                        completionHandler(nil,err.toNSError())
                    }
                }
            }
            task.resume()
        } catch let err {
            completionHandler(nil,err.toNSError())
        }
    }

    func put(_ path: String, body: [String: Any], _ completionHandler: StatusReturned? = nil) {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
            let url = URL(string: "\(apiUrl)\(path)") else {
                completionHandler?(
                    NSError(domain: "dbmanager.put", code: 404, userInfo: [NSLocalizedDescriptionKey: "API not found. Please make sure you're connected to Amada's VPN"]
                    )
                )
                return
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = try PropertyListSerialization.data(
                fromPropertyList: body,
                format: .binary,
                options: 0
            )
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
            completionHandler?(error.toNSError())
        }
    }

}
