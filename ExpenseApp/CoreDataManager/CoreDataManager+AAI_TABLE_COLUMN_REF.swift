//
//  CoreDataManager+TableColRef.swift
//  ExpenseApp
//
//  Created by IT Support on 3/15/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import CoreData

typealias tableColRefListReturned = ([AAI_TABLE_COLUMN_REF]?, NSError) -> Void

extension CoreDataManager {
    func getTableColRef(columnName: String, _ completionHandler: tableColRefListReturned?) {
    }

    func createTableColRef(models: [AAI_TABLE_COLUMN_REF], _ completionHandler: StatusReturned? = nil) {
        models.forEach { (model) in
            let context = persistentContainer.viewContext
            let object = NSEntityDescription.insertNewObject(forEntityName: "AAI_TABLE_COLUMN_REF_CORE", into: context) as! AAI_TABLE_COLUMN_REF_CORE
            object.setValue(model.TABLE_NAME, forKey: "table_name")
            object.setValue(model.COLUMN_NAME, forKey: "column_name")
            object.setValue(model.COLUMN_VALUE, forKey: "column_value")
            object.setValue(model.DESCRIPTION, forKey: "desc")
            object.setValue(model.COMMENTS, forKey: "comments")
            object.setValue(model.ACTIVE_STATUS, forKey: "active_status")
            object.setValue(model.SOURCE, forKey: "source")
            object.setValue(model.CREATED_DATE, forKey: "created_date")
            object.setValue(model.CREATED_BY, forKey: "created_by")
            object.setValue(model.CHANGED_DATE, forKey: "changed_date")
            object.setValue(model.CHANGED_BY, forKey: "changed_by")
            object.setValue(model.SORT_ORDER, forKey: "sort_order")
            object.setValue(model.CO_CODE, forKey: "co_code")
            object.setValue(model.ATTRIBUTE1, forKey: "attribute1")
            object.setValue(model.ATTRIBUTE2, forKey: "attribute2")
            object.setValue(model.ATTRIBUTE3, forKey: "attribute3")
            object.setValue(model.COMMENTS2, forKey: "comments2")
            object.setValue(model.FRENCH_DESCRIPTION, forKey: "french_description")
            object.setValue(model.SPANISH_DESCRIPTION, forKey: "spanish_description")
            do {
                try context.save()
                completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "TableColumnRef records saved in iPhone"]))
            } catch let err {
                completionHandler?(err.toNSError())
                return
            }
        }
    }

    func getAAI_TABLE_COLUMN_REF_CORE(_ completionHandler: tableColRef_CORE_ListReturned?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AAI_TABLE_COLUMN_REF_CORE>(entityName: "AAI_TABLE_COLUMN_REF_CORE")
        do {
            let models = try context.fetch(fetchRequest)
            completionHandler?(models, nil)
        } catch let error {
            completionHandler?(nil, error)
        }
    }

    func getAAI_TABLE_COLUMN_REF(_ completionHandler: tableColRefListReturned?) {
        getAAI_TABLE_COLUMN_REF_CORE { (coreModels, error) in
            if let error = error {
                completionHandler?(nil, error.toNSError())
                return
            }
            guard let coreModels = coreModels else {
                completionHandler?(nil, NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "No TableColRef records in iPhone."]))
                return
            }
            var models = [AAI_TABLE_COLUMN_REF]()
            coreModels.forEach({ (coreModel) in
                let model = AAI_TABLE_COLUMN_REF(coreModel)
                models.append(model)
            })
            completionHandler?(models, NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "TableColRef records from iPhone returned"]))
        }
    }

    func deleteAAI_TABLE_COLUMN_REF(_ completionHandler: StatusReturned? = nil) {
        getAAI_TABLE_COLUMN_REF_CORE { (coreModels, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }

            guard let coreModels = coreModels else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No table column reference records stored in iPhone"]))
                return
            }

            for coreModel in coreModels {
                self.deleteAAI_TABLE_COLUMN_REF(model: coreModel)
            }
            completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "All TableColRef records deleted from iPhone."]))
        }
    }

    func deleteAAI_TABLE_COLUMN_REF(model: AAI_TABLE_COLUMN_REF_CORE, _ completionHandler: StatusReturned? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Table Column Reference record deleted from iPhone."]))
        } catch let error {
            completionHandler?(error.toNSError())
        }
    }
}
