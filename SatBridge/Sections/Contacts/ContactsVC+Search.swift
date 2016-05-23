//
//  ContactsVC+Search.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 213//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit
import Contacts

extension ContactsVC {
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    tableView.tableHeaderView = searchController.searchBar
    tableView.contentOffset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
  }
}

extension ContactsVC: UISearchBarDelegate {
  
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!)
  }
}

extension ContactsVC: UISearchResultsUpdating {
  
  // MARK: - UISearchResultsUpdating
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  // MARK: - Public
  func filterContentForSearchText(searchText: String) {
    contactsFiltered = contacts.filter({( contact : CNContact) -> Bool in
      
      var digits = ""
      if let phoneNumb = contact.phoneNumbers.first {
        digits = (phoneNumb.value as! CNPhoneNumber).valueForKey("digits") as! String
      }

      return contact.givenName.lowercaseString.containsString(searchText.lowercaseString)
          || contact.familyName.lowercaseString.containsString(searchText.lowercaseString)
          || digits.lowercaseString.containsString(searchText.lowercaseString)

    })
    tableView.reloadData()
  }
}