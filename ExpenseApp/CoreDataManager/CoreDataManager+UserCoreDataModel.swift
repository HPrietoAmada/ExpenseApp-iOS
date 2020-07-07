//
//  CoreDataManager+UserCoreDataModel.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/26/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import CoreData

typealias UserCoreDataModelReturned = (UserCoreDataModel?, NSError) -> Void

extension CoreDataManager {

    func saveUserSession(sessionModel: SessionModel, _ completionHandler: StatusReturned? = nil) {
        let context = persistentContainer.viewContext
        let model = NSEntityDescription.insertNewObject(forEntityName: "UserCoreDataModel", into: context) as! UserCoreDataModel

        guard let content = sessionModel.Content,
            let user = content.UserDetails else {
                completionHandler?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unable to save session"]))
            return
        }

        if let user_id = user.USER_ID {
            model.setValue(user_id, forKey: "user_id")
        }

        if let password = user.PASSWORD {
            model.setValue(password, forKey: "password")
        }

        if let email = user.EMAIL {
            model.setValue(email, forKey: "email")
        }

        if let name_first = user.NAME_FIRST {
            model.setValue(name_first, forKey: "name_first")
        }

        if let name_last = user.NAME_LAST {
            model.setValue(name_last, forKey: "name_last")
        }

        if let title = user.TITLE {
            model.setValue(title, forKey: "title")
        }

        if let reports_to = user.REPORTS_TO {
            model.setValue(reports_to, forKey: "reports_to")
        }

        if let company_id = user.COMPANY_ID {
            model.setValue(company_id, forKey: "company_id")
        }

        if let company_code = user.COMPANY_CODE {
            model.setValue(company_code, forKey: "company_code")
        }

        if let division_id = user.DIVISION_ID {
            model.setValue(division_id, forKey: "division_id")
        }

        if let division_code = user.DIVISION_CODE {
            model.setValue(division_code, forKey: "division_code")
        }

        if let department_id = user.DEPARTMENT_ID {
            model.setValue(department_id, forKey: "department_id")
        }

        if let office_id = user.OFFICE_ID {
            model.setValue(office_id, forKey: "office_id")
        }

        if let region_id = user.REGION_ID {
            model.setValue(region_id, forKey: "region_id")
        }

        if let sbu_id = user.SBU_ID {
            model.setValue(sbu_id, forKey: "sbu_id")
        }

        if let sales_num = user.SALES_NUM {
            model.setValue(sales_num, forKey: "sales_num")
        }

        if let home_dept = user.HOME_DEPT {
            model.setValue(home_dept, forKey: "home_dept")
        }

        if let vendor_num = user.VENDOR_NUM {
            model.setValue(vendor_num, forKey: "vendor_num")
        }

        if let rep_code = user.REP_CODE {
            model.setValue(rep_code, forKey: "rep_code")
        }

        if let service_role = user.SERVICE_ROLE {
            model.setValue(service_role, forKey: "service_role")
        }

        if let phone = user.PHONE {
            model.setValue(phone, forKey: "phone")
        }

        if let ext = user.EXT {
            model.setValue(ext, forKey: "ext")
        }

        if let fax = user.FAX {
            model.setValue(fax, forKey: "fax")
        }

        if let pager = user.PAGER {
            model.setValue(pager, forKey: "pager")
        }

        if let cell = user.CELL {
            model.setValue(cell, forKey: "cell")
        }

        if let cell_provider = user.CELL_PROVIDER {
            model.setValue(cell_provider, forKey: "cell_provider")
        }

        if let mobile_email = user.MOBILE_EMAIL {
            model.setValue(mobile_email, forKey: "mobile_email")
        }

        if let home_address = user.HOME_ADDRESS {
            model.setValue(home_address, forKey: "home_address")
        }

        if let home_city = user.HOME_CITY {
            model.setValue(home_city, forKey: "home_city")
        }

        if let home_state = user.HOME_STATE {
            model.setValue(home_state, forKey: "home_state")
        }

        if let home_zip = user.HOME_ZIP {
            model.setValue(home_zip, forKey: "home_zip")
        }

        if let home_workphone = user.HOME_WORKPHONE {
            model.setValue(home_workphone, forKey: "home_workphone")
        }

        if let home_phone = user.HOME_PHONE {
            model.setValue(home_phone, forKey: "home_phone")
        }

        if let home_fax = user.HOME_FAX {
            model.setValue(home_fax, forKey: "home_fax")
        }

        if let photo_url = user.PHOTO_URL {
            model.setValue(photo_url, forKey: "photo_url")
        }

        if let is_deleted = user.IS_DELETED {
            model.setValue(is_deleted, forKey: "is_deleted")
        }

        if let createdString = user.CREATED,
            let created = createdString.getDate() {
            model.setValue(created, forKey: "created")
        }

        if let updatedString = user.UPDATED,
            let updated = updatedString.getDate() {
            model.setValue(updated, forKey: "updated1")
        }

        if let created_id = user.CREATED_ID {
            model.setValue(created_id, forKey: "created_id")
        }

        if let updated_id = user.UPDATED_ID {
            model.setValue(updated_id, forKey: "updated_id")
        }

        if let home_lat = user.HOME_LAT {
            model.setValue(home_lat, forKey: "home_lat")
        }

        if let home_lon = user.HOME_LON {
            model.setValue(home_lon, forKey: "home_lon")
        }

        if let android_id = user.ANDROID_ID {
            model.setValue(android_id, forKey: "android_id")
        }

        if let plant = user.PLANT {
            model.setValue(plant, forKey: "plant")
        }

        if let region_id_service = user.REGION_ID_SERVICE {
            model.setValue(region_id_service, forKey: "region_id_service")
        }

        if let language = user.LANGUAGE {
            model.setValue(language, forKey: "language")
        }

        if let co_code = user.CO_CODE {
            model.setValue(co_code, forKey: "co_code")
        }

        if let username = user.USERNAME {
            model.setValue(username, forKey: "username")
        }

        if let password_ad = user.PASSWORD_AD {
            model.setValue(password_ad, forKey: "password_ad")
        }

        if let emp_id = user.EMP_ID {
            model.setValue(emp_id, forKey: "emp_id")
        }

        if let prefer_name_first = user.PREFER_NAME_FIRST {
            model.setValue(prefer_name_first, forKey: "prefer_name_first")
        }

        if let prefer_name_last = user.PREFER_NAME_LAST {
            model.setValue(prefer_name_last, forKey: "prefer_name_last")
        }

        if let sap_access_grp = user.SAP_ACCESS_GRP {
            model.setValue(sap_access_grp, forKey: "sap_access_grp")
        }

        if let hire_dateString = user.HIRE_DATE,
            let hire_date = hire_dateString.getDate() {
            model.setValue(hire_date, forKey: "hire_date")
        }

        if let display_name = user.DISPLAY_NAME {
            model.setValue(display_name, forKey: "display_name")
        }

        do {
            try context.save()
            completionHandler?(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "User session saved."]))
        } catch let err {
            completionHandler?(err.toNSError())
        }
    }

    func logUserOut() -> (Error?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCoreDataModel>(entityName: "UserCoreDataModel")

        do {
            let model = try context.fetch(fetchRequest)
            model.forEach { (model) in
                context.delete(model)
            }
            try context.save()
        } catch let err {
            return err
        }
        return nil
    }

    func logout(_ completionHandler: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCoreDataModel>(entityName: "UserCoreDataModel")

        do {
            let model = try context.fetch(fetchRequest)
            model.forEach { (model) in
                context.delete(model)
            }
            try context.save()
            completionHandler(true, nil)
        } catch let err {
            completionHandler(false, err)
        }
    }

    /*
     Purpose: Returns userCoreDataModel if user is currently logged in
        Else returns an error object
     */
    func getCurrentUser() -> (UserCoreDataModel?, Error?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCoreDataModel>(entityName: "UserCoreDataModel")

        do {
            let model = try context.fetch(fetchRequest).first
            return (model, nil)
        } catch let err {
            return (nil, err)
        }
    }

    func getCurrentUser(_ callback: UserCoreDataModelReturned) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCoreDataModel>(entityName: "UserCoreDataModel")
        do {
            let model = try context.fetch(fetchRequest).first
            callback(model, NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Current user returned"]))
        } catch let err {
            callback(nil, err.toNSError())
        }
    }

    func userIsLoggedIn() -> Bool {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserCoreDataModel>(entityName: "UserCoreDataModel")

        do {
            let model = try context.fetch(fetchRequest)
            return model.count != 0
        } catch {
            return false
        }
    }
}
