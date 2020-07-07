//
//  DBManager+Feedback.swift
//  ExpenseApp
//
//  Created by IT Support on 5/24/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

extension DBManager {

    // POST: api/feedback/{feedback}/username/{username}
    func provideFeedback(username: String, feedback: String, _ completionHandler: StatusReturned? = nil) {
        let path: String = "feedback/\(feedback)/username/\(username)"
        put(path, completionHandler)
    }
}
