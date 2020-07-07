//
//  DBManager+DBUser.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

typealias SessionModelReturned = (_ sessionModel: SessionModel?, _ error: NSError) -> Void

extension DBManager {

    func login(email: String,
               password: String,
               _ completionHandler: SessionModelReturned? = nil) {
        guard let loginPath: String = Bundle.main.object(forInfoDictionaryKey: "LOGIN_URL") as? String,
            let url: URL = URL(string: "\(loginPath)LoginGet/?Email=\(email)&Password=\(password)") else {
                completionHandler?(
                    nil, NSError(
                        domain: "LOGIN",
                        code: 400,
                        userInfo: [
                            NSLocalizedDescriptionKey: "Unable to reach servers. Please make sure you're connected to Amada's VPN"
                        ]
                )
            )
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler?(nil, error.toNSError())
                    return
                }

                guard let data = data else {
                    completionHandler?(
                        nil,
                        NSError(domain: "", code: 204, userInfo: [ NSLocalizedDescriptionKey: "Not data returned" ])
                    )
                    return
                }

                do {
                    let sessionModel = try JSONDecoder().decode(SessionModel.self, from: data)
                    completionHandler?(
                        sessionModel,
                        NSError(domain: "", code: 201, userInfo: [ NSLocalizedDescriptionKey: "Expense successfully created" ])
                    )
                } catch let err {
                    completionHandler?(
                        nil,
                        err.toNSError()
                    )
                }
            }
        }
        task.resume()
    }
}
