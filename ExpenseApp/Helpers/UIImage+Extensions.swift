//
//  UIImage+Extensions.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/16/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension UIImage {

    func toByteArray() -> [UInt8]? {
        guard let data = UIImagePNGRepresentation(self) else {
            return nil
        }
        return [UInt8](data)
    }
}
