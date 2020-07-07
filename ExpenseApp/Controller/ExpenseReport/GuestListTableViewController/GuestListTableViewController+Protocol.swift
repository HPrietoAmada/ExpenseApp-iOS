//
//  GuestListTableViewController+Protocol.swift
//  ExpenseApp
//
//  Created by HPrietoAmada on 5/1/20.
//  Copyright © 2020 IT Support. All rights reserved.
//

import UIKit

extension GuestListTableViewController: UserSearchTableViewControllerDelegate {
    func userSearchTableViewController(_ controller: UserSearchTableViewController, selected users: [User], error: NSError) {
        print("selected users: \(users.count)")
        return
        // Get Current Logged-In User
        CoreDataManager.shared.getCurrentUser { (coreUser, error) in
            guard let user = coreUser,
                let username = user.username else {
                return
            }
            // Create EXP_DTL_GUESTS out of WEB_IT_USERS returned from user search view
            var guestList: [EXP_DTL_GUESTS] = [EXP_DTL_GUESTS]()
            users.forEach { (u) in
                var guest = EXP_DTL_GUESTS()
                guest.guestUserId = u.USER_ID
                guest.guestName = u.DISPLAY_NAME
                guest.isDeleted = "N"
                guest.createdBy = username
                guest.changedBy = username
                // If guests are being added already created expense, add:
                // WEB_VIA2.EXP_DTL_GUESTS.EXP_ID
                // WEB_VIA2.EXP_DTL_GUESTS.EXP_DTL_ID
                if let trip = self.trip,
                    let expId = trip.ID {
                    guest.expId = expId
                }
                if let expense = self.expense,
                    let expDtlId = expense.ID {
                    guest.expDtlId = expDtlId
                }
                guestList.append(guest)
            }

            // Check if guests are being added to an existing expense or a new expense
            guard let expense = self.expense, let expenseId = expense.ID else {
                // Guests are being selected to an expense that's not yet created
                self.models = guestList
                controller.navigationController?.popViewController(animated: true)
                    return
            }
            // Insert guestList records into oracle
            DBManager.shared.createGuests(guestList) { (err) in
                if err.code >= 300 {
                    self.presentAlert(title: "Error", message: error.localizedDescription)
                    controller.navigationController?.popViewController(animated: true)
                    return
                }
                // Retrieve newly created guests and display them to user
                DBManager.shared.getExpenseGuests(expenseId) { (data, er) in
                    guard let newGuestList = data else {
                        self.presentAlert(title: "Error", message: er.localizedDescription)
                        controller.navigationController?.popViewController(animated: true)
                        return
                    }
                    self.models = newGuestList
                }
            }
        }
    }

    func userSearchTableViewController(_ controller: UserSearchTableViewController, deleted user: User) {
        controller.navigationController?.popViewController(animated: true)
    }


}
