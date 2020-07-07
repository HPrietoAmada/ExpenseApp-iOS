//
//  EXP_DTL_GUESTS.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/10/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import Foundation

struct EXP_DTL_GUESTS: Codable {
    public var id: Int?
    public var expId: Int?
    public var expDtlId: Int?
    public var guestUserId: Int?
    public var guestName: String?
    public var isDeleted: String?
    public var createdDate: String?
    public var createdBy: String?
    public var changedDate: String?
    public var changedBy: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case expId = "EXP_ID"
        case expDtlId = "EXP_DTL_ID"
        case guestUserId = "GUEST_USER_ID"
        case guestName = "GUEST_NAME"
        case isDeleted = "IS_DELETED"
        case createdDate = "CREATED_DATE"
        case createdBy = "CREATED_BY"
        case changedDate = "CHANGED_DATE"
        case changedBy = "CHANAGED_BY"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        expId = try values.decodeIfPresent(Int.self, forKey: .expId)
        expDtlId = try values.decodeIfPresent(Int.self, forKey: .expDtlId)
        guestUserId = try values.decodeIfPresent(Int.self, forKey: .guestUserId)
        guestName = try values.decodeIfPresent(String.self, forKey: .guestName)
        isDeleted = try values.decodeIfPresent(String.self, forKey: .isDeleted)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        changedDate = try values.decodeIfPresent(String.self, forKey: .changedDate)
        changedBy = try values.decodeIfPresent(String.self, forKey: .changedBy)
    }

    init() {
        id = 0
        expId = 0
        expDtlId = 0
        guestUserId = 0
        guestName = ""
        isDeleted = ""
        createdDate = ""
        createdBy = ""
        changedDate = ""
        changedBy = ""
    }

    func getUser(users: inout [User]) -> User? {
        return users.first(where: { $0.USER_ID == self.guestUserId })
    }
}

struct UserGuestsModel: Codable {
    public var GUESTS: [User]?
    init(_ guests: [User]) {
        self.GUESTS = guests
    }
}
