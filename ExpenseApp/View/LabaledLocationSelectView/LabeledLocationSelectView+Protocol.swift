//
//  LocationSelectView+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 12/14/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import GooglePlaces

extension LabeledLocationSelectView: GMSAutocompleteViewControllerDelegate {

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.place = place

        guard let delegate = delegate else {
            return
        }

        delegate.labeledLocationSelectView(self, gmsAutocompleteViewController: viewController, placeChosen: place, tag: tag)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {

    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        guard let delegate = delegate else {
            return
        }

        delegate.dismiss(viewController)
    }

}
