//
//  UserSearchTableViewController+Protocol.swift
//  AmadaTimeOff
//
//  Created by IT Support on 1/9/19.
//  Copyright © 2019 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UserSearchTableViewController: UISearchBarDelegate {

    /*
     //////
     SearchBar Protocol Methds
     //////
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Remove already selected users
        self.filteredUsers = users.filter {
            "\($0.DISPLAY_NAME ?? "") \($0.NAME_FIRST ?? "") \($0.EMAIL ?? "")".uppercased().contains(searchText.uppercased())
        }.filter{ user in
            !guests.contains(where: { $0.guestUserId == user.USER_ID })
        }
        tableView.reloadData()
    }
}
