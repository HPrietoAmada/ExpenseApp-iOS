//
//  UserDefaults+Extension.swift
//  AmadaTimeOff
//
//  Created by IT Support on 9/24/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UserDefaults {

    enum UserDefaultsKeys: String {
        case user
    }

    func login(username: String, password: String) {
        set(WEB_IT_USERS(), forKey: UserDefaultsKeys.user.rawValue)
        synchronize()
    }

    func logout() {
        removeObject(forKey: UserDefaultsKeys.user.rawValue)
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.user.rawValue)
    }

}
