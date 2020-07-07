//
//  CoreDataManager+EXP_FILES.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/17/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {

    func createExpFiles(_ model: EXP_FILES, _ completionHandler: StatusReturned? = nil) {
        let context = persistentContainer.viewContext
        let coreModel = NSEntityDescription.insertNewObject(forEntityName: "EXP_FILES_CORE", into: context) as! EXP_FILES_CORE
        coreModel.setValue(model.id, forKey: "id")
        coreModel.setValue(model.expId, forKey: "expId")
        coreModel.setValue(model.expDtlId, forKey: "expDtlId")
        coreModel.setValue(model.fileName, forKey: "fileName")
        coreModel.setValue(model.title, forKey: "title")
        coreModel.setValue(model.createdDate, forKey: "createdDate")
        coreModel.setValue(model.createdBy, forKey: "createdBy")
        coreModel.setValue(model.changedDate, forKey: "changedDate")
        coreModel.setValue(model.changedBy, forKey: "changedBy")
        do {
            try context.save()
            completionHandler?(
                NSError(
                    domain: "CoreDataManager.createExpFiles",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "Ok"]
                )
            )
        } catch let error {
            completionHandler?(error.toNSError())
        }
    }

    func getExpFiles(_ completionHandler: ([EXP_FILES_CORE]?, NSError) -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_FILES_CORE>(entityName: "EXP_FILES_CORE")
        do {
            let coreModels = try context.fetch(fetchRequest)
            completionHandler(
                coreModels,
                NSError(
                    domain: "CoreDataManager.getExpFiles",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "Ok"]
                )
            )
        } catch let error {
            completionHandler(nil, error.toNSError())
        }
    }

    func deleteExpFiles(_ model: EXP_FILES_CORE, _ completionHandler: StatusReturned? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(
                NSError(
                    domain: "CoreDataManager.deleteExpFiles",
                    code: 200,
                    userInfo: [NSLocalizedDescriptionKey: "Ok"]
                )
            )
        } catch let error {
            completionHandler?(error.toNSError())
        }
    }
}
