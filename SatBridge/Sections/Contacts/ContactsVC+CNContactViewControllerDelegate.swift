//
//  ContactsVC+CNContactViewControllerDelegate.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import ContactsUI

extension ContactsVC: CNContactViewControllerDelegate {
  
  // MARK: - CNContactViewControllerDelegate
  func contactViewController(vc: CNContactViewController, didCompleteWithContact con: CNContact?) {
    self.tabBarController?.tabBar.hidden = false
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  func contactViewController(vc: CNContactViewController, shouldPerformDefaultActionForContactProperty prop: CNContactProperty) -> Bool {
    return false
  }
  
  // MARK: - Public
  
  func getContactsAndSortThem() {
    
    self.contacts = CONTACTS_HANDLER.getAllContacts()
    
    for customContact in self.contacts {
      let fullName = customContact.givenName + customContact.familyName
      contactsFullNames.append(fullName)
    }
    
    contactsFullNames = capitalizeFirstLetterInArrayOfStrings(contactsFullNames)
    contactsFullNames = contactsFullNames.sort(<)
    contactsSectionTitles = getInitialsFromArrayOfStrings(contactsFullNames.initials)
    contactsDictionary = CONTACTS_HANDLER.getContactsDictionary(forContactsSectionTitles: self.contactsSectionTitles, fromContactList: self.contacts)
  }
}