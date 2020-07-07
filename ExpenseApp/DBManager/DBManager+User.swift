//
//  DBManager+User.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/9/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation
fileprivate var userCache: NSCache = NSCache<NSString, AnyObject>()
fileprivate let cacheKey: NSString = "WEB_IT.USERS"
extension DBManager {

    func getUsers(_ completionHandler: @escaping DataReturned<[User]>) {
        if let cachedUsers = userCache.object(forKey: cacheKey) as? [User] {
            completionHandler(
                cachedUsers,
                NSError(
                    domain: "",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "success"]
            ))
            return
        }
        let path: String = "user"
        get(path) { (users: [User]?, error) in
            guard let users = users else {
                completionHandler(nil, error)
                return
            }
            completionHandler(users, error)
            userCache.setObject(users as AnyObject, forKey: cacheKey)
        }
    }

}
