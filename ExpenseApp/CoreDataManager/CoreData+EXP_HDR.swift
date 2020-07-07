//
//  CoreData+EXP_HDR.swift
//  ExpenseApp
//
//  Created by IT Support on 3/17/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import CoreData



extension CoreDataManager {

    func createEXP_HDR_CORE(model: EXP_HDR, _ completionHandler: @escaping ObjectReturned<EXP_HDR_CORE>) {
        let context = persistentContainer.viewContext
        let coreModel = NSEntityDescription.insertNewObject(forEntityName: "EXP_HDR_CORE", into: context) as! EXP_HDR_CORE

        // Assign ID
        getEXP_HDR_CORE { (coreModels, error) in
            if let coreModels = coreModels {
                let coreID: Int = coreModels.count + 1
                coreModel.setValue(coreID, forKey: "id")
            } else {
                let randomID: Int = Int.random(in: 1000 ..< 10000)
                coreModel.setValue(randomID, forKey: "id")
            }
        }

        coreModel.setValue(model.CO_CODE, forKey: "co_code")
        coreModel.setValue(model.USER_ID, forKey: "user_id")
        coreModel.setValue(model.EMP_ID, forKey: "emp_id")
        coreModel.setValue(model.EMP_VENDOR_NUM, forKey: "emp_vendor_num")
        coreModel.setValue(model.BEG_DATE, forKey: "beg_date")
        coreModel.setValue(model.END_DATE, forKeyPath: "end_date")
        coreModel.setValue(model.EXP_STATUS, forKey: "exp_status")
        coreModel.setValue(model.TRIP_TYPE, forKey: "trip_type")
        coreModel.setValue(model.TRIP_NAME, forKey: "trip_name")
        coreModel.setValue(model.PURPOSE, forKey: "purpose")
        coreModel.setValue(model.CASH_ON_HAND, forKey: "cash_on_hand")
        coreModel.setValue(model.CASH_ADVANCED, forKey: "cash_advanced")
        coreModel.setValue(model.PR_ID, forKey: "pr_id")
        coreModel.setValue(model.AWA_NUMBER, forKey: "awa_number")
        coreModel.setValue(model.COST_CENTER, forKey: "cost_center")
        coreModel.setValue(model.PROFIT_CENTER, forKey: "profit_center")
        coreModel.setValue(model.REQUESTED_DATE, forKey: "requested_date")
        coreModel.setValue(model.REQUESTED_BY, forKey: "requested_by")
        coreModel.setValue(model.SUBMITTED_DATE, forKey: "submitted_date")
        coreModel.setValue(model.SUBMITTED_BY, forKey: "submitted_by")
        coreModel.setValue(model.MGR_APPROVED_DATE, forKey: "mgr_approved_date")
        coreModel.setValue(model.MGR_APPROVED_BY, forKey: "mgr_approved_by")
        coreModel.setValue(model.MGR_REJECTED_REASON, forKey: "mgr_rejected_reason")
        coreModel.setValue(model.MGR_REJECTED_DATE, forKey: "mgr_rejected_date")
        coreModel.setValue(model.MGR_REJECTED_BY, forKey: "mgr_rejected_by")
        coreModel.setValue(model.CREATED_DATE, forKey: "created_date")
        coreModel.setValue(model.CREATED_BY, forKey: "created_by")
        coreModel.setValue(model.CHANGED_DATE, forKey: "changed_date")
        coreModel.setValue(model.CHANGED_BY, forKey: "changed_by")
        coreModel.setValue(model.NOTES, forKey: "notes")
        coreModel.setValue(model.ACC_APPROVED_DATE, forKey: "acc_approved_date")
        coreModel.setValue(model.ACC_APPROVED_BY, forKey: "acc_approved_by")
        coreModel.setValue(model.ACC_REJECTED_REASON, forKey: "acc_rejected_reason")
        coreModel.setValue(model.ACC_REJECTED_DATE, forKey: "acc_rejected_date")
        coreModel.setValue(model.ACC_REJECTED_BY, forKey: "acc_rejected_by")

        do {
            try context.save()
            completionHandler(
                coreModel,
                NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Success"])
            )
        } catch let error {
            completionHandler(nil, error.toNSError())
        }
    }

    func createEXP_HDR(model: EXP_HDR, _ completionHandler: @escaping (EXP_HDR?, Error?) -> Void) {
        createEXP_HDR_CORE(model: model) { (coreModel, error) in
            if let coreModel = coreModel {
                let newModel = EXP_HDR(coreModel)
                completionHandler(newModel, error)
                return
            }
            completionHandler(nil, error)
        }
    }

    func getEXP_HDR(_ completionHandler: @escaping ([EXP_HDR]?, Error?) -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_HDR_CORE>(entityName: "EXP_HDR_CORE")
        var models = [EXP_HDR]()
        do {
            let modelCores = try context.fetch(fetchRequest)
            modelCores.forEach { (modelCore) in
                let model = EXP_HDR(modelCore)
                models.append(model)
            }
            completionHandler(models, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }

    func getEXP_HDR_CORE(_ completionHandler: @escaping ([EXP_HDR_CORE]?, Error?) -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_HDR_CORE>(entityName: "EXP_HDR_CORE")

        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let error {
            completionHandler(nil, error)
        }
    }

    func deleteEXP_HDR(_ completionHandler: StatusReturned? = nil) {
        getEXP_HDR_CORE { (models, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }

            guard let models = models else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No expenses are stored"]))
                return
            }

            for model in models {
                let context = CoreDataManager.shared.persistentContainer.viewContext
                context.delete(model)
                do {
                    try context.save()
                    completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "All stored expenses deleted"]))
                } catch let err {
                    completionHandler?(err.toNSError())
                    return
                }
            }
        }
    }

    func deleteEXP_HDR(model: EXP_HDR_CORE, _ completionHandler: StatusReturned? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Trip deleted"]))
        } catch let error {
            completionHandler?(error.toNSError())
        }
    }

    // Gets all EXP_HDR and EXP_DTL stored locally in device
    func getExpenseModels(_ completionHandler: @escaping ([TripModel]?, Error?) -> Void) {
        var models: [TripModel] = [TripModel]()
        getEXP_HDR { (tripModels, tripError) in
            if let tripError = tripError {
                completionHandler(nil, tripError)
                return
            }
            guard let tripModels = tripModels else {
                completionHandler(nil, nil)
                return
            }
            self.getEXP_DTL({ (expenseModels, error) in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let expenseModels = expenseModels else {
                    completionHandler(nil, nil)
                    return
                }

                for exp_hdr in tripModels {
                    var expenseModel = TripModel()
                    expenseModel.Trip = exp_hdr
                    expenseModel.Expenses = expenseModels.filter({ $0.EXP_ID == exp_hdr.ID })
                    models.append(expenseModel)
                }
            })
        }
        completionHandler(models, nil)
    }

    func deleteExpenseCoreModel(coreModel: ExpenseCoreModel, _ completionHandler: StatusReturned? = nil) {
        if let trip = coreModel.Trip {
            self.deleteEXP_HDR(model: trip)
        }
        if let expenses = coreModel.Expenses {
            expenses.forEach { (expense) in
                self.deleteEXP_DTL(model: expense)
            }
        }
    }

    func deleteAllExpenseCoreModels(_ completionHandler: StatusReturned? = nil) {
        self.deleteEXP_DTL() { (error) in
            completionHandler?(error)
        }
        self.deleteEXP_HDR() { (error) in
            completionHandler?(error)
        }
    }

    func getExpenseCoreModels(_ completionHandler: @escaping ([ExpenseCoreModel]?, Error?) -> Void) {
        var models: [ExpenseCoreModel] = [ExpenseCoreModel]()
        getEXP_HDR_CORE { (tripModels, tripError) in
            if let tripError = tripError {
                completionHandler(nil, tripError)
                return
            }
            guard let tripModels = tripModels else {
                completionHandler(nil, nil)
                return
            }
            self.getEXP_DTL_CORE({ (expenseModels, error) in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                guard let expenseModels = expenseModels else {
                    completionHandler(nil, nil)
                    return
                }

                for exp_hdr in tripModels {
                    var expenseModel = ExpenseCoreModel()
                    expenseModel.Trip = exp_hdr
                    expenseModel.Expenses = expenseModels.filter({ $0.exp_id == exp_hdr.id })
                    models.append(expenseModel)
                }
            })
        }
        completionHandler(models, nil)
    }

    func deleteEXP_HDR(model: EXP_HDR, _ completionHandler: StatusReturned? = nil) {
        getEXP_HDR_CORE { (models, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }
            guard let models = models, let coreModel = models.first(where: { Int($0.id) == model.ID }) else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Trip doesn't exist"]))
                return
            }

            self.deleteEXP_HDR(model: coreModel) { (err) in
                completionHandler?(err)
            }
        }
    }

    func updateEXP_HDR(coreModel: EXP_HDR_CORE, model: EXP_HDR, _ completionHandler: @escaping (Bool, Error?) -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_HDR_CORE>(entityName: "EXP_HDR_CORE")

        do {
            let coreModels = try context.fetch(fetchRequest)
            guard let updateModel = coreModels.first(where: { $0.id == coreModel.id }) else {
                completionHandler(false, nil)
                return
            }
            updateModel.setValue(model.TRIP_NAME, forKey: "trip_name")
            updateModel.setValue(model.BEG_DATE, forKey: "beg_date")
            updateModel.setValue(model.END_DATE, forKey: "end_date")
            updateModel.setValue(model.TRIP_TYPE, forKey: "trip_type")
            updateModel.setValue(model.PURPOSE, forKey: "purpose")
            updateModel.setValue(model.CASH_ON_HAND, forKey: "cash_on_hand")
            updateModel.setValue(model.CASH_ADVANCED, forKey: "cash_advanced")
            updateModel.setValue(model.AWA_NUMBER, forKey: "awa_number")
            updateModel.setValue(model.NOTES, forKey: "notes")

            do {
                try context.save()
                completionHandler(true, nil)
            } catch let err {
                completionHandler(false, err)
            }
        } catch let error {
            completionHandler(false, error)
        }
    }
}
