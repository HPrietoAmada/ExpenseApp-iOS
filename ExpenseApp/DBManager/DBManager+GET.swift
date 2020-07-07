//
//  DBManager+GET.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/16/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension DBManager {

    func get<T:Decodable>(_ path: String, _ completionHandler: @escaping (T?, NSError) -> Void) {
        guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
            let url = URL(string: "\(apiUrl)\(path)") else {
            completionHandler(
                nil,
                NSError(domain: "", code: 404, userInfo: [ NSLocalizedDescriptionKey: "API not found" ])
            )
            return
        }

        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil,error.toNSError())
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(
                        nil,
                        NSError(domain: "", code: 204, userInfo: [ NSLocalizedDescriptionKey: "No data found" ])
                    )
                }
                return
            }

            do {
                let models = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(
                        models,
                        NSError(domain: "", code: response.statusCode, userInfo: [ NSLocalizedDescriptionKey: response.description ])
                    )
                }
            } catch let err {
                DispatchQueue.main.async {
                    completionHandler(nil,err.toNSError())
                }
            }
        }
        task.resume()
    }

}
