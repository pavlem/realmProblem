//
//  CallsVC+Search.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit


extension CallsVC {
  
  //MARK: - Public
  func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.hidesNavigationBarDuringPresentation = false
    
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.scopeButtonTitles = [""]
    
    tableView.tableHeaderView = searchController.searchBar
    tableView.contentOffset = CGPointMake(0, self.searchController.searchBar.frame.size.height);
  }
  
  func getActiveCallLogAtIndexPathRow(indexPath: NSIndexPath) -> CallLog {
    
    var callLog = CallLog()
    if searchController.active && searchController.searchBar.text != "" {
      callLog = callsFiltered[indexPath.row]
    } else {
      callLog = callsScope[indexPath.row]
    }
        
    return callLog
  }
  
  func filterContentBasedOnScope(selectedScope: String) {
   
    callsScope = callsAll.filter({ (callLog : CallLog) -> Bool in
      
      let anyStatus = callLog.status
      
      if selectedScope == StatusCallLog.all {
        return callLog.status == anyStatus
      } else {
        return callLog.status == selectedScope
      }
    })
    
    tableView.reloadData()
  }
  
  //MARK: - Private
  private func filterContentForSearchText(searchText: String, scope: String = "") {
    callsFiltered = callsScope.filter({( contact : CallLog) -> Bool in
      let categoryMatch = (scope == "") || (contact.status == scope)
      return categoryMatch && (contact.contactName.lowercaseString.containsString(searchText.lowercaseString) ||
                               contact.contactNumber.lowercaseString.containsString(searchText.lowercaseString))
    })
    tableView.reloadData()
  }
}

// MARK: - UISearchResultsUpdating
extension CallsVC: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

// MARK: - UISearchBarDelegate
extension CallsVC: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    let selectedScope = searchBar.scopeButtonTitles![selectedScope]
    filterContentBasedOnScope(selectedScope)
  }
}