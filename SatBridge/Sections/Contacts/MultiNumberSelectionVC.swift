//
//  MultiNumberSelectionVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 194//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts

class MultiNumberSelectionVC: SBTableVC {

  // MARK: - Properties -
  var contact: CNContact?
  var isCallSelected = false
  
  
  // MARK: - Private -
  private func pushCallScreenVC(callLog: CallLog) {
    
    let callScreenVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.callScreenVC) as! CallScreenVC
    callScreenVC.callLog = callLog
    callScreenVC.isOpenModally = true
    
    self.presentViewController(callScreenVC, animated: true, completion: nil)
  }
  
  private func openCallScreen(indexPath: NSIndexPath) {
    let normalizedPhoneNum = CONTACTS_HANDLER.getUnformatedNumberAsString(contact!.phoneNumbers[indexPath.row])
    
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
      callLog.contactName = contact!.givenName + " " + contact!.familyName
      callLog.contactNumber = normalizedPhoneNum
      callLog.timeStamp = NSDate().timeIntervalSince1970
      callLog.duration = "22"
      
      callLog.status = StatusCallLog.dialed
      if let imageData = contact!.thumbnailImageData {
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
  
  private func openMessageThreadScreen(indexPath: NSIndexPath) {
    
    let normalizedPhoneNum = CONTACTS_HANDLER.getContactNormPhoneNumb(contact!, atIndex: indexPath.row)
    
    let messageThreadVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.messageThreadVC) as! MessageThreadVC
    messageThreadVC.recipientNumber = normalizedPhoneNum
    messageThreadVC.recipientName = CONTACTS_HANDLER.getContactFullName(contact!)
    messageThreadVC.threadId = normalizedPhoneNum
    messageThreadVC.thumbImageData = contact!.thumbnailImageData
    
    NAV_HANDLER.getCurrentNavController().tabBarController?.selectedIndex = 0
    NAV_HANDLER.getCurrentNavController().pushViewController(messageThreadVC, animated: true)
    NAV_HANDLER.getCurrentNavController().tabBarController?.tabBar.hidden = true
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}

// MARK: - Extensions -
extension MultiNumberSelectionVC: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.multiSelectionCell, forIndexPath: indexPath)
    
    let phoneNumber = contact!.phoneNumbers[indexPath.row]
    let cnPhoneNumber = phoneNumber.value as! CNPhoneNumber
    cell.textLabel?.text = cnPhoneNumber.stringValue
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (contact?.phoneNumbers.count)!
  }
}

extension MultiNumberSelectionVC: UITableViewDelegate {
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if isCallSelected {
      openCallScreen(indexPath)
    } else {
      openMessageThreadScreen(indexPath)
    }
  }
}