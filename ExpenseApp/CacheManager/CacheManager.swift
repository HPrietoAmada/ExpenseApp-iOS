//
//  CacheManager.swift
//  AmadaTimeOff
//
//  Created by IT Support on 2/14/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

struct CacheManager {

    static let shared = CacheManager()

    let cache = NSCache<NSString, AnyObject>()

    func get<T>(key: NSString,
                _ completionHandler: @escaping(_ data: T?) -> Void) {
        if let cachedObject = cache.object(forKey: key) {
            completionHandler(cachedObject as? T)
            return
        }
        completionHandler(nil)
    }

    func put<T>(key: NSString, object: T) {
        cache.setObject(object as AnyObject, forKey: key)
    }
}
