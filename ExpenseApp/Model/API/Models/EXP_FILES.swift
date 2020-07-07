//
//  EXP_FILES.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/28/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import Foundation
import UIKit

struct EXP_FILES: Codable {
    public var id: Int?
    public var expId: Int?
    public var expDtlId: Int?
    public var fileName: String?
    public var fileSize: Int?
    public var title: String?
    public var isDeleted: Bool?
    public var createdDate: String?
    public var createdBy: String?
    public var changedDate: String?
    public var changedBy: String?
    public var FileBytes: [UInt8]?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case expId = "EXP_ID"
        case expDtlId = "EXP_DTL_ID"
        case fileName = "FILE_NAME"
        case fileSize = "FILE_SIZE"
        case title = "TITLE"
        case createdDate = "CREATED_DATE"
        case createdBy = "CREATED_BY"
        case changedDate = "CHANGED_DATE"
        case changedBy = "CHANGED_BY"
        case FileBytes = "FileBytes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        expId = try values.decodeIfPresent(Int.self, forKey: .expId)
        expDtlId = try values.decodeIfPresent(Int.self, forKey: .expDtlId)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        fileSize = try values.decodeIfPresent(Int.self, forKey: .fileSize)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        changedDate = try values.decodeIfPresent(String.self, forKey: .changedDate)
        changedBy = try values.decodeIfPresent(String.self, forKey: .changedBy)
        FileBytes = try values.decodeIfPresent([UInt8].self, forKey: .FileBytes)
    }

    init() {
        self.id = 0
        self.expId = 0
        self.expDtlId = 0
        self.fileName = ""
        self.fileSize = 0
        self.title = ""
        self.createdDate = Date().toDateTime()
        self.createdBy = ""
        self.changedDate = Date().toDateTime()
        self.changedBy = ""
    }

    init(_ image: UIImage) {
        self.init()
        self.FileBytes = image.toByteArray()
    }

    init(_ coreModel: EXP_FILES_CORE) {
        self.id = Int(coreModel.id)
        self.expId = Int(coreModel.expId)
        self.expDtlId = Int(coreModel.expDtlId)
        self.fileName = coreModel.fileName
        self.fileSize = Int(coreModel.fileSize)
        self.title = coreModel.title
        self.createdDate = coreModel.createdDate
        self.createdBy = coreModel.createdBy
        self.changedDate = coreModel.changedDate
        self.changedBy = coreModel.changedBy
        if let fileData = coreModel.fileBytes {
            self.FileBytes = [UInt8](fileData)
        }
    }
}
