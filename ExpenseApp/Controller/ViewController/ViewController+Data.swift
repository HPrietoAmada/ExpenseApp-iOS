//
//  ViewController+Data.swift
//  ExpenseApp
//
//  Created by IT Support on 3/18/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIViewController {
    /*
     Purpose
     Gets all active records from AAI_TABLE_COLUMN_REF and stores locally for online/offline user
     */
    func setAAI_TABLE_COLUMN_REF(tableColRef: [AAI_TABLE_COLUMN_REF]) {
        CoreDataManager.shared.deleteAAI_TABLE_COLUMN_REF({ (erro) in
            if erro.code >= 300 {
                self.presentAlert(title: "Error", message: erro.localizedDescription)
                return
            }
            CoreDataManager.shared.createTableColRef(models: tableColRef, { (err) in
                if err.code >= 300 {
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    return
                }
            })
        })
    }

    func getMileageGasRate(type: String = "MI") -> Double? {
        var rate: Double?
        CoreDataManager.shared.getAAI_TABLE_COLUMN_REF { (models, error) in
            guard let models = models else {
                return
            }
            let mileageRateRef = models.filter({ $0.COLUMN_NAME == "MILEAGE_RATE" })
            guard let mileageType = mileageRateRef.first(where: { $0.DESCRIPTION == type }),
                let mileageRate = mileageType.COLUMN_VALUE else {
                    return
            }
            rate = Double(mileageRate)
        }
        return rate
    }
}
