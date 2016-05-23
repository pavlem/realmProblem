//
//  MessagesVC+Search.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 84//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MessagesVC {

  //MARK: - Public
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.scopeButtonTitles = ["All", "Sent", "Received"]
    tableView.tableHeaderView = searchController.searchBar
    tableView.contentOffset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
  }
  
  //MARK: - Private
  private func filterContentForSearchText(searchText: String, scope: String = "All") {
    messagesFiltered = messagesScope.filter({( messages : Messages) -> Bool in
      let categoryMatch = (scope == "All") || (messages.status == scope)
      
      return categoryMatch && (messages.recipientNumber.lowercaseString.containsString(searchText.lowercaseString)
                            || messages.recipientName.lowercaseString.containsString(searchText.lowercaseString))
    })
    tableView.reloadData()
  }
  
  private func filterContentBasedOnScope(selectedScope: String) {
    messagesScope = messagesAll.filter({ (messages : Messages) -> Bool in
      if selectedScope == "All" {
        return messages.status == "Sent" || messages.status == "Received"
      } else {
        return messages.status == selectedScope
        
      }
    })
    tableView.reloadData()
  }
}

// MARK: - UISearchResultsUpdating
extension MessagesVC: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

// MARK: - UISearchBarDelegate
extension MessagesVC: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    let selectedScope = searchBar.scopeButtonTitles![selectedScope]
    //    filterContentForSearchText(searchBar.text!, scope: selectedScope)
    filterContentBasedOnScope(selectedScope)
  }
}