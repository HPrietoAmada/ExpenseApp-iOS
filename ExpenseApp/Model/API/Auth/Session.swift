//
//  Session.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/26/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation

struct Session: Codable {
    var SessionId: String?
    var Username: String?
    var Email: String?
    var DisplayName: String?
    var UserId: Int?
    var UserDetails: User?
    var UserGroups: [String]?
    var Valid: Bool?
    var IpAddress: String?
    var AuthHeader: String?
    var Expires: String?
}
