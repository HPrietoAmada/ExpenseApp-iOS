//
//  EXP_HDRViewController+Handlers.swift
//  ExpenseApp
//
//  Created by IT Support on 4/14/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension EXP_HDRViewController {

    @objc func updateTrip() {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }
        updateTripModel { (model, error) in
            guard let model = model else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            DBManager.shared.updateTrip(model: model) { (err) in
                if error.code >= 300 {
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    return
                }
                if let delegate = self._formSubmitDelegate {
                    delegate.viewController(
                        self,
                        formSubmitError: NSError(
                            domain: "EXP_HDRViewController.UpdateTrip",
                            code: 200,
                            userInfo: [NSLocalizedDescriptionKey: "Success"]
                        ),
                        tag: self.tag
                    )
                }
                self.goBack()
            }
        }
    }

    @objc func createTrip() {
        print("Creating trip...")
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }
        // create WEB_VIA2.EXP_HDR model from input fields
        createTripModel { (model, error) in
            guard let tripModel = model else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
            // INSERT into WEB_VIA2.EXP_HDR
            DBManager.shared.createTrip(model: tripModel) { (err) in
                print(err.localizedDescription)
                if error.code >= 300 {
                    self.storeTripLocally(model: tripModel)
                    self.presentAlert(title: "Error", message: err.localizedDescription)
                    return
                }
                if let delegate = self._formSubmitDelegate {
                    delegate.viewController(
                        self,
                        formSubmitError: NSError(
                            domain: "EXP_HDRViewController.createTrip",
                            code: 200,
                            userInfo: [NSLocalizedDescriptionKey: "Success"]
                        ),
                        tag: self.tag
                    )
                }
                self.goBack()
            }
        }
    }


    func storeTripLocally(model: EXP_HDR) {
        // Store locally until internet connection is found
        CoreDataManager.shared.createEXP_HDR_CORE(model: model, { (coreModel, error) in
            guard let _ = coreModel else {
                self.presentAlert(title: "Error", message: error.localizedDescription)
                return
            }
        })
    }

    @objc func submitTrip() {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }
        let alertController = UIAlertController(title: "Submitting Trip", message: "Your manager will be notified that you have submitted a trip for approval. Continue?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            guard let exp_hdr = self.trip,
                let tripID = exp_hdr.ID else {
                    return
            }
            CoreDataManager.shared.getCurrentUser { (user, error) in
                guard let user = user, let username = user.username else {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    return
                }
                DBManager.shared.submitTrip(id: tripID, username: username, status: "SUBMIT") { (err) in
                    if err.code >= 300 {
                        self.presentAlert(title: "Error", message: err.localizedDescription)
                    }
                    self.goBack()
                }
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc func deleteTrip() {
        if lowPowerModeON() {
            self.batteryModeAlert()
            return
        }
        let alertController = UIAlertController(title: "Deleting Trip",
                                                message: "Deleting trip also deletes all of it's expenses.",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
            // WEB_VIA2.EXP_HDR model needs to be deleted
            if let exp_hdr = self.trip,
                let tripID = exp_hdr.ID {
                DBManager.shared.deleteTrip(id: tripID)
                if let delegate = self._formSubmitDelegate {
                    delegate.viewController(
                        self,
                        formSubmitError: NSError(
                            domain: "EXP_HDRViewController.deleteTrip",
                            code: 200,
                            userInfo: [NSLocalizedDescriptionKey: "Success"]
                        ),
                        tag: self.tag
                    )
                }
                self.goBack()
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}
