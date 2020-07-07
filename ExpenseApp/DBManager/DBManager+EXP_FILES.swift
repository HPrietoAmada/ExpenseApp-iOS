//
//  DBManager+Image.swift
//  ExpenseApp
//
//  Created by IT Support on 5/29/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation
import UIKit

extension DBManager {

    func uploadFiles(_ models: [EXP_FILES], _ completionHandler: @escaping StatusReturned) {
        let path: String = "expense/files"
        put(models, path: path, completionHandler)
    }

}
