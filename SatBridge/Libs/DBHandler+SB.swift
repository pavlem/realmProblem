//
//  DBHandler+SB.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 313//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import Contacts

extension DBHandler {
  
  // MARK: - Sat Bridge Realm Object Models -
  
  
  // MARK: - Settings -
  func getSettingsForPK(key: String) -> Settings? {
    return uiRealm.objectForPrimaryKey(Settings.self, key:key)
  }
  
  func getCopyOfUniqueSettingsObjectFromDB() -> Settings {
    return Settings(value: uiRealm.objectForPrimaryKey(Settings.self, key: "settingsObject_PK")!)
  }
  
  
  // MARK: - CallLog -
  func deleteCallLogObjects() {
    self.deleteRealmClassesFromDB(CallLog)
    self.deleteRealmClassesFromDB(CallLogInfo)
  }
  
  func  getObjectsForCallLogModel() -> Results<CallLog> {
    return uiRealm.objects(CallLog)
  }
  
  func getCallLogForPK(key: String) -> CallLog? {
    return uiRealm.objectForPrimaryKey(CallLog.self, key:key)
  }
  
  func getCallLogForPhoneNumber(phoneNum: String) -> CallLog? {
    return uiRealm.objects(CallLog).filter("contactName = '\(phoneNum)' OR contactNumber = '\(phoneNum)'").first
  }
  
  func getCallLogFilteredByKeyName(keyName: String, andKeyValue keyValue: String) -> Results<CallLog> {
    let callLogFiltered = uiRealm.objects(CallLog).filter("id = '\(keyValue)'")
    return callLogFiltered
  }
  
  func updateCallLogInDB(callLog: CallLog) {

    DB_HANDLER.update(callLog)
  }
  
  func appendCallLogInfoToCallLog(callLogInfo: CallLogInfo, callLog: CallLog) {
    
    do {
      try uiRealm.write {
        callLog.callLogInfos.append(callLogInfo)
      }
    } catch {
      self.dbAlertFeedback("DB_Update_Failed")
    }
  }
  
  func createCallLogInDB(dialNumber: String) {
    
    let contactTuple = CONTACTS_HANDLER.getContactForCallScreen(dialNumber)
    let contactForCallScreen = contactTuple.cnContact
    
    let callLog = CallLog()
    
    if contactTuple.isNumberInContacts {
      callLog.contactName = contactForCallScreen!.givenName
      callLog.photoThumbImage = contactForCallScreen!.thumbnailImageData
    } else {
      callLog.contactName = dialNumber
    }
    
    callLog.id = dialNumber
    callLog.threadId = dialNumber
    callLog.contactNumber = dialNumber
    callLog.timeStamp = NSDate().timeIntervalSince1970
    callLog.duration = "44"
    callLog.status = StatusCallLog.dialed
    
    let callLogInfo = CallLogInfo()
    callLogInfo.id = NSUUID().UUIDString
    callLogInfo.threadId = dialNumber
    callLogInfo.status = StatusCallLog.dialed
    callLogInfo.duration = "222"
    callLogInfo.timeStamp = NSDate().timeIntervalSince1970
    
    callLog.callLogInfos.append(callLogInfo)
    
    DB_HANDLER.add(callLog)
  }
  
  func createCallLogInDBForContact(contact: CNContact) {
    
    let callLog = CallLog()
    
    callLog.id = contact.identifier
    callLog.contactName = contact.givenName + " " + contact.familyName
    let phoneNum = (contact.phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
    callLog.contactNumber = phoneNum
    callLog.threadId = phoneNum
    callLog.status = StatusCallLog.dialed
    callLog.duration = "22"
    callLog.timeStamp = NSDate().timeIntervalSince1970
    if let imageData = contact.thumbnailImageData {
      callLog.photoThumbImage = imageData
    }
    
    DB_HANDLER.add(callLog)
  }
  
  // MARK: - Inbox -
  func getThreadMessages(threadId: String) -> Results<Message> {
    return uiRealm.objects(Message).filter("threadId == '\(threadId)'")
  }
  
  func getThreadMessages(threadId: String, sortedBy sortingString: String) -> Results<Message> {
    let threadMssgs = getThreadMessages(threadId)
    return threadMssgs.sorted(sortingString)
  }
  
  func deleteAllMessages() {
    try! uiRealm.write {
      uiRealm.delete(uiRealm.objects(Messages))
      uiRealm.delete(uiRealm.objects(Message))
    }
  }
  
  func getDistinctThreadsStrings() -> [String] {
    return uiRealm.objects(Messages).uniqueValue("threadId", type: String.self)
  }
  
  func getLastMessageOfAThread(threadString: String) -> Messages? {
    return uiRealm.objects(Messages).filter("threadId == '\(threadString)'").sorted("timeStamp").reverse().first
  }
  
  
  // MARK: - Message Thread -
  func getMssgThreadForPK(pk: String) -> Messages? {
    return uiRealm.objectForPrimaryKey(Messages.self, key: pk)
  }

  
  // MARK: - TechLog -
}