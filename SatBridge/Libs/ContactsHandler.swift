//
//  ContactsHandler.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI
import UIKit


class ContactsHandler  {
  
  func getAllContacts() -> [CNContact] {
    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactThumbnailImageDataKey, CNContactImageDataAvailableKey]
    let containerId = CNContactStore().defaultContainerIdentifier()
    let predicate: NSPredicate = CNContact.predicateForContactsInContainerWithIdentifier(containerId)
    
    var contacts = [CNContact()]
    
    do {
      contacts = try CNContactStore().unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)
      
    } catch {
      
    }
    
    return contacts
  }
  
  func createContactVC() -> CNContactViewController {
    let store = CNContactStore()
    let contact = CNMutableContact()
    let controller = CNContactViewController(forNewContact: contact)
    controller.contactStore = store
    
    return controller
  }
  
  func createContactVCWithPhoneNumber(phoneNumb: String) -> CNContactViewController {
    let store = CNContactStore()
    let contact = CNMutableContact()
    let controller = CNContactViewController(forNewContact: contact)
    controller.contactStore = store

    contact.phoneNumbers = [CNLabeledValue(
      label:CNLabelPhoneNumberiPhone,
      value:CNPhoneNumber(stringValue:phoneNumb))]

    return controller
  }
  
  func getContactsDictionary(forContactsSectionTitles contactsSectionTitles: [String], fromContactList contactList: [CNContact]) -> [String: [CNContact]] {
    
    var contactsDictionary = [String: [CNContact]]()
    
    for key in contactsSectionTitles {
      var tempContactsForKey = [CNContact]()
      for contact in contactList {
        if key == contact.givenName.first {
          tempContactsForKey.append(contact)
        }
      }
      
      contactsDictionary[key] = tempContactsForKey
    }
    
    return contactsDictionary
  }
  
  func getAllDeviceContactsForANumber(digits: String) -> [CNMutableContact]  {
    var contactsFilteredByNumber = [CNMutableContact]()
    
    let contacts = getAllContacts()
    
    for contact in contacts {
      
      if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
        for phoneNumber in contact.phoneNumbers {
          let a = phoneNumber.value as! CNPhoneNumber
          if a.stringValue.digitsOnly() ==  digits {
            let mContact = contact.mutableCopy()
            contactsFilteredByNumber.append(mContact as! CNMutableContact)
          }
        }
      }
    }
    
    return contactsFilteredByNumber
  }
  
  func getUnformatedNumberAsString(phoneNumb: CNLabeledValue) -> String  {
    let digits = (phoneNumb.value as! CNPhoneNumber).valueForKey("digits") as! String
    return digits
  }
  
  func getContactForCallScreen(digits:String) -> (cnContact: CNMutableContact?, isNumberInContacts: Bool)  {
    
    var contactForCallScreen = CNMutableContact()
    
    let contactsFilteredByNumber = getAllDeviceContactsForANumber(digits)
    
    var isContactInDB = false
    if contactsFilteredByNumber.count > 0 {
      contactForCallScreen = contactsFilteredByNumber.first!
      isContactInDB = true
    } else {
      contactForCallScreen.givenName = digits
    }
    
    return (contactForCallScreen, isContactInDB)
  }
  
  func extractPropertiesFromContact(cnContact: CNContact) -> (fullname: String, phoneNumber: String, thumbnailImageData: NSData?, id: String) {
    
    let fullName = cnContact.givenName + " " + cnContact.familyName
    var phoneNumberString = ""
    
    if let phoneNumber = cnContact.phoneNumbers.first {
      let phoneNumber = phoneNumber.value as! CNPhoneNumber
      phoneNumberString = phoneNumber.stringValue
    }
    
    return (fullName, phoneNumberString, cnContact.thumbnailImageData, cnContact.identifier)
  }
  
  
  // MARK: - Properties extraction - 
  func getContactFullName(contact: CNContact) -> String {
    return contact.givenName + " " + contact.familyName
  }
  
  func getContactNormPhoneNumb(contact: CNContact, atIndex index: Int) -> String {
    let phoneNumb = contact.phoneNumbers[index]
    let digits = (phoneNumb.value as! CNPhoneNumber).valueForKey("digits") as! String
    return digits
  }
  
//  func getContactThumbImage() {
//    
//  }
}
