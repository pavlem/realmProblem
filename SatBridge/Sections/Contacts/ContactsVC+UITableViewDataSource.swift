//
//  ContactsVC+UITableViewDataSource.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit
import Contacts

extension ContactsVC: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView:UITableView)->Int {
    if searchController.active && searchController.searchBar.text != "" {
      return 1
    }
    return self.contactsSectionTitles.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return self.contactsFiltered.count
    }
    
    let sectionTitle = contactsSectionTitles[section]
    let sectionContacts = contactsDictionary[sectionTitle]!
    
    return sectionContacts.count
  }
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    return self.contactsSectionTitles
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    if searchController.active && searchController.searchBar.text != "" {
      return ""
    }
    return contactsSectionTitles[section]
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.contactCell, forIndexPath: indexPath) as! ContactCell
    var contact = contacts[indexPath.row]
    
    if searchController.active && searchController.searchBar.text != "" {
      contact = contactsFiltered[indexPath.row]
    } else {
      
      let sectionTitle = contactsSectionTitles[indexPath.section]
      let sectionContacts = contactsDictionary[sectionTitle]!
      
      contact = sectionContacts[indexPath.row]
    }
    
    cell.fullName.text = contact.givenName + " " + contact.familyName
    
    if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
      
      if let phoneNumber:CNLabeledValue = contact.phoneNumbers.first {
        let phoneNumberString = phoneNumber.value as! CNPhoneNumber
        
        cell.phone.text = phoneNumberString.stringValue
        cell.phone.hidden = false
      }
      
//      for phoneNumber:CNLabeledValue in contact.phoneNumbers {
//        let a = phoneNumber.value as! CNPhoneNumber
//        print("\(a.stringValue)")
//        cell.phone.text = a.stringValue
//        cell.phone.hidden = false
//      }
    }
    
    if let thumbImage = contact.thumbnailImageData {
      cell.contactImage.image = UIImage(data:thumbImage)
    }
    
    return cell
  }
}