//
//  CoreData+EXP_DTL.swift
//  ExpenseApp
//
//  Created by IT Support on 3/17/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import CoreData

extension CoreDataManager {

    /*
     Parameters
     - model: EXP_DTL => WEB_VIA2.EXP_DTL model
     Purpose
     - Takes model parameters of type WEB_VIA2.EXP_DTL and stores it locally in device
     */
    func createEXP_DTL(model: EXP_DTL, _ completionHandler: EXP_DTL_Returned?) {
        let context = persistentContainer.viewContext

        let exp_dtl = NSEntityDescription.insertNewObject(forEntityName: "EXP_DTL_CORE", into: context) as! EXP_DTL_CORE
        // Assign ID
        getEXP_DTL_CORE { (coreModels, error) in
            if let coreModels = coreModels {
                let coreID: Int = coreModels.count + 1
                exp_dtl.setValue(coreID, forKey: "id")
            } else {
                let randomID: Int = Int.random(in: 1000 ..< 10000)
                exp_dtl.setValue(randomID, forKey: "id")
            }
        }
        exp_dtl.setValue(model.EXP_ID, forKey: "exp_id")
        exp_dtl.setValue(model.EXP_LINE, forKey: "exp_line")
        exp_dtl.setValue(model.EXP_DESC, forKey: "exp_desc")
        exp_dtl.setValue(model.EXP_TYPE, forKey: "exp_type")
        exp_dtl.setValue(model.EXP_BEG_DATE, forKey: "exp_beg_date")
        exp_dtl.setValue(model.EXP_END_DATE, forKey: "exp_end_date")
        exp_dtl.setValue(model.MEAL_TYPE, forKey: "meal_type")
        exp_dtl.setValue(model.MEAL_LOCATION, forKey: "meal_location")
        exp_dtl.setValue(model.CURRENCY, forKey: "currency")
        exp_dtl.setValue(model.TOTAL_AMOUNT, forKey: "total_amount")
        exp_dtl.setValue(model.NET_AMOUNT, forKey: "net_amount")
        exp_dtl.setValue(model.TIPS_AMOUNT, forKey: "tips_amount")
        exp_dtl.setValue(model.EXC_RATE, forKey: "exc_rate")
        exp_dtl.setValue(model.ROUND_TRIP_FLAG, forKey: "round_trip_flag")
        exp_dtl.setValue(model.ODO_UOM, forKey: "odo_uom")
        exp_dtl.setValue(model.ODO_FROM, forKey: "odo_from")
        exp_dtl.setValue(model.ODO_TO, forKey: "odo_to")
        exp_dtl.setValue(model.BEG_LAT, forKey: "beg_lat")
        exp_dtl.setValue(model.BEG_LON, forKey: "beg_lon")
        exp_dtl.setValue(model.END_LAT, forKey: "end_lat")
        exp_dtl.setValue(model.END_LON, forKey: "end_lon")
        exp_dtl.setValue(model.MILEAGE_RATE, forKey: "mileage_rate")
        exp_dtl.setValue(model.BEG_LOC_NAME, forKey: "beg_loc_name")
        exp_dtl.setValue(model.BEG_LOC_ADDR1, forKey: "beg_loc_addr1")
        exp_dtl.setValue(model.BEG_LOC_ADDR2, forKey: "beg_loc_addr2")
        exp_dtl.setValue(model.BEG_LOC_CITY, forKey: "beg_loc_city")
        exp_dtl.setValue(model.BEG_LOC_STATE, forKey: "beg_loc_state")
        exp_dtl.setValue(model.BEG_LOC_ZIP, forKey: "beg_loc_zip")
        exp_dtl.setValue(model.BEG_LOC_COUNTRY, forKey: "beg_loc_country")
        exp_dtl.setValue(model.END_LOC_NAME, forKey: "end_loc_name")
        exp_dtl.setValue(model.END_LOC_ADDR1, forKey: "end_loc_addr1")
        exp_dtl.setValue(model.END_LOC_ADDR2, forKey: "end_loc_addr2")
        exp_dtl.setValue(model.END_LOC_CITY, forKey: "end_loc_city")
        exp_dtl.setValue(model.END_LOC_STATE, forKey: "end_loc_state")
        exp_dtl.setValue(model.END_LOC_ZIP, forKey: "end_loc_zip")
        exp_dtl.setValue(model.END_LOC_COUNTRY, forKey: "end_loc_country")
        exp_dtl.setValue(model.CREATED_DATE, forKey: "created_date")
        exp_dtl.setValue(model.CREATED_BY, forKey: "created_by")
        exp_dtl.setValue(model.CHANGED_DATE, forKey: "changed_date")
        exp_dtl.setValue(model.CHANGED_BY, forKey: "changed_by")
        exp_dtl.setValue(model.NOTES, forKey: "notes")
        exp_dtl.setValue(model.PER_DIEM_FLAG, forKey: "per_diem_flag")
        exp_dtl.setValue(model.GL_ACCOUNT, forKey: "gl_account")

        let newModel = EXP_DTL(exp_dtl)
        do {
            try context.save()
            completionHandler?(newModel, nil)
        } catch let error {
            completionHandler?(nil, error)
        }
    }

    /*
     Purpose
     - Retreives ALL locally stored objects of type 'EXP_DTL_CORE'
     */
    func getEXP_DTL_CORE(_ completionHandler: EXP_DTL_CORE_ListReturned?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_DTL_CORE>(entityName: "EXP_DTL_CORE")
        do {
            let models = try context.fetch(fetchRequest)
            completionHandler?(models, nil)
        } catch let error {
            completionHandler?(nil, error)
        }
    }

    /*
     Purpose
        - Retreives ALL locally stored objects of type 'EXP_DTL_CORE' as types 'EXP_DTL'
     */
    func getEXP_DTL(_ completionHandler: EXP_DTL_ListReturned?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_DTL_CORE>(entityName: "EXP_DTL_CORE")
        var models = [EXP_DTL]()
        do {
            let modelCores = try context.fetch(fetchRequest)
            modelCores.forEach { (modelCore) in
                let model = EXP_DTL(modelCore)
                models.append(model)
            }
            completionHandler?(models, nil)
        } catch let error {
            completionHandler?(nil, error)
        }
    }

    /*
     Purpose
     - Deletes ALL locally stored objects of type EXP_DTL_CORE
     */
    func deleteEXP_DTL(_ completionHandler: StatusReturned? = nil) {
        getEXP_DTL_CORE { (models, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }
            guard let models = models else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey: "No models exist" ]))
                return
            }
            for model in models {
                let context = CoreDataManager.shared.persistentContainer.viewContext
                context.delete(model)
                do {
                    try context.save()
                    completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Locally stored expenses deleted."]))
                } catch let err {
                    completionHandler?(err.toNSError())
                    return
                }
            }
        }
    }

    /*
     Parameters
     - model: EXP_DTL_CORE => locally stored model to be deleted
     Purpose
     - Deletes parameter model to be deleted
     */
    func deleteEXP_DTL(model: EXP_DTL_CORE, _ completionHandler: StatusReturned? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Expense deleted from iPhone memory"]))
        } catch let error {
            completionHandler?(error.toNSError())
        }
    }

    /*
     Parameters
     - model: EXP_DTL => locally stored model to be deleted
     Purpose
     - Deletes parameter model to be deleted
     */
    func deleteEXP_DTL(model: EXP_DTL, _ completionHandler: StatusReturned? = nil) {
        getEXP_DTL_CORE { (models, error) in
            if let error = error {
                completionHandler?(error.toNSError())
                return
            }
            guard let models = models,
                let coreModel = models.first(where: { Int($0.id) == model.ID }) else {
                    completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unable to delete expense"]))
                return
            }

            self.deleteEXP_DTL(model: coreModel) { (err) in
                completionHandler?(err)
            }
        }
    }

    /*
     Parameters
        - coreModel: EXP_DTL_CORE => WEB_VIA2.EXP_DTL stored in local storage
        - model: EXP_DTL => WEB_VIA2.EXP_DTL model with updated values
     Purpose
        - Updates the values of locally stored model
        - Returns 'True' if update was successful
        - Returns 'False' if update was not successful
     */
    func updateEXP_DTL(coreModel: EXP_DTL_CORE, model: EXP_DTL, _ completionHandler: ProgressComplete?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EXP_DTL_CORE>(entityName: "EXP_HDR_CORE")

        do {
            let coreModels = try context.fetch(fetchRequest)
            guard let updateModel = coreModels.first(where: { $0.id == coreModel.id }) else {
                completionHandler?(false, nil)
                return
            }
            updateModel.setValue(model.EXP_DESC, forKey: "exp_desc")
            updateModel.setValue(model.EXP_TYPE, forKey: "exp_type")
            updateModel.setValue(model.BEG_LAT, forKey: "beg_lat")
            updateModel.setValue(model.BEG_LON, forKey: "beg_lon")
            updateModel.setValue(model.BEG_LOC_NAME, forKey: "beg_loc_name")
            updateModel.setValue(model.BEG_LOC_ADDR1, forKey: "beg_loc_addr1")
            updateModel.setValue(model.BEG_LOC_ADDR2, forKey: "beg_loc_addr2")
            updateModel.setValue(model.BEG_LOC_STATE, forKey: "beg_loc_state")
            updateModel.setValue(model.BEG_LOC_CITY, forKey: "beg_loc_city")
            updateModel.setValue(model.BEG_LOC_COUNTRY, forKey: "beg_loc_country")
            updateModel.setValue(model.BEG_LOC_ZIP, forKey: "beg_loc_zip")

            do {
                try context.save()
                completionHandler?(true, nil)
            } catch let err {
                completionHandler?(false, err)
            }
        } catch let error {
            completionHandler?(false, error)
        }
    }
}
