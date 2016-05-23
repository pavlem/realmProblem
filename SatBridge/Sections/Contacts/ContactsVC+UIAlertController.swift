//
//  ContactsVC+UIAlertController.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Contacts

extension ContactsVC: AlertViewHandlerDelegate {
  
  // MARK: - Private
  private func smsTheContact(contact:CNContact) {
    
    if contact.phoneNumbers.count > 1 {
      
      let sb = NAV_HANDLER.mainSB
      let vc = sb.instantiateViewControllerWithIdentifier(Identifier.multiNumberSelectionVC) as! MultiNumberSelectionVC
      vc.contact = contact
      vc.isCallSelected = false
      
      NAV_HANDLER.getCurrentNavController().pushViewController(vc, animated: true)
      NAV_HANDLER.getCurrentNavController().tabBarController?.tabBar.hidden = true
      
      self.dismissViewControllerAnimated(true, completion: nil)
      
    } else {
      
      let messageThreadVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.messageThreadVC) as! MessageThreadVC
      let contactProperties = CONTACTS_HANDLER.extractPropertiesFromContact(contact)
      messageThreadVC.recipientNumber = contactProperties.phoneNumber
      messageThreadVC.recipientName = contactProperties.fullname
      messageThreadVC.threadId = contactProperties.phoneNumber
      messageThreadVC.thumbImageData = contactProperties.thumbnailImageData
      
      NAV_HANDLER.getCurrentNavController().tabBarController?.selectedIndex = 0
      NAV_HANDLER.getCurrentNavController().pushViewController(messageThreadVC, animated: true)
      NAV_HANDLER.getCurrentNavController().tabBarController?.tabBar.hidden = true
      
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  private func callTheContact(contact:CNContact) {
    
    if contact.phoneNumbers.count > 1 {
      
      let sb = NAV_HANDLER.mainSB
      let vc = sb.instantiateViewControllerWithIdentifier(Identifier.multiNumberSelectionVC) as! MultiNumberSelectionVC
      vc.contact = contact
      vc.isCallSelected = true
            
      NAV_HANDLER.getCurrentNavController().pushViewController(vc, animated: true)
      NAV_HANDLER.getCurrentNavController().tabBarController?.tabBar.hidden = true
      
      self.dismissViewControllerAnimated(true, completion: nil)

    } else {
      
      let normalizedPhoneNum = CONTACTS_HANDLER.getUnformatedNumberAsString(contact.phoneNumbers.first!)
      
      if let callLog = DB_HANDLER.getCallLogForPK(normalizedPhoneNum) {
        
        let callLogLocal = CallLog(value: callLog)
        callLogLocal.timeStamp = NSDate().timeIntervalSince1970
        
        let callLogInfo = CallLogInfo()
        callLogInfo.duration = "12"
        callLogInfo.id = NSUUID().UUIDString
        callLogInfo.status = StatusCallLog.dialed
        callLogInfo.timeStamp = NSDate().timeIntervalSince1970
        callLogInfo.threadId = callLog.threadId
        callLogLocal.callLogInfos.append(callLogInfo)
        
        DB_HANDLER.updateCallLogInDB(callLogLocal)
        pushCallScreenVC(callLogLocal)
        
      } else {
        
        let callLog = CallLog()
        
        callLog.id = normalizedPhoneNum
        callLog.threadId = normalizedPhoneNum
        callLog.contactName = contact.givenName + " " + contact.familyName
        callLog.contactNumber = normalizedPhoneNum
        callLog.timeStamp = NSDate().timeIntervalSince1970
        callLog.duration = "22"
        
        callLog.status = StatusCallLog.dialed
        if let imageData = contact.thumbnailImageData {
          callLog.photoThumbImage = imageData
        }
        
        let callLogInfo = CallLogInfo()
        callLogInfo.duration = "12"
        callLogInfo.id = NSUUID().UUIDString
        callLogInfo.status = StatusCallLog.dialed
        callLogInfo.timeStamp = NSDate().timeIntervalSince1970
        callLogInfo.threadId = callLog.threadId
        callLog.callLogInfos.append(callLogInfo)
        
        DB_HANDLER.add(callLog)
        
        if let callLog = DB_HANDLER.getCallLogForPK(callLog.id) {
          pushCallScreenVC(callLog)
        }
      }
    }
    
    //      for phoneNumber:CNLabeledValue in contact.phoneNumbers {
    //        let a = phoneNumber.value as! CNPhoneNumber
    //        print("\(a.stringValue)")
    //        cell.phone.text = a.stringValue
    //        cell.phone.hidden = false
    //      }
    
    
    
    
  }
  
  private func pushCallScreenVC(callLog: CallLog) {
    
    let callScreenVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.callScreenVC) as! CallScreenVC
    callScreenVC.callLog = callLog
    callScreenVC.isOpenModally = true
    callScreenVC.isOpenedFromContainer = isOpenedFromContainer
    
    self.presentViewController(callScreenVC, animated: true, completion: nil)
  }
  
  private func getActiveContactAtIndexPathRow(indexPath: NSIndexPath) -> CNContact {
    
    var contact = CNContact()
    if searchController.active && searchController.searchBar.text != "" {
      contact = contactsFiltered[indexPath.row]
    } else {
      let sectionTitle = contactsSectionTitles[indexPath.section]
      let sectionContacts = contactsDictionary[sectionTitle]!
      
      contact = sectionContacts[indexPath.row]
    }
    
    return contact
  }
  
  
  // MARK: - Public
  func createActionSheet(indexPath: NSIndexPath) {
    let contact = getActiveContactAtIndexPathRow(indexPath)
    ALERT_HANDLER.createActionSheetWithMessage(contact.givenName, actionOneTitle: Config.alertSendSMS, actionTwoTitle: Config.alertCall, actionThreeTitle:"",  cancelTitle: Config.alertCancel, withIndexPathRow: indexPath, andDelegate: self)
  }
  
  
  // MARK: - AlertViewHandlerDelegate
  func actionOne(indexPath: NSIndexPath) {
    smsTheContact(getActiveContactAtIndexPathRow(indexPath))
  }
  
  func actionTwo(indexPath: NSIndexPath) {
    callTheContact(getActiveContactAtIndexPathRow(indexPath))
  }
}