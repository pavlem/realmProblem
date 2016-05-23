//
//  CallsVC+UIAlertController.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension CallsVC: AlertViewHandlerDelegate {
  
  // MARK: - Private
  private func openContactCallLogHistory(callLog: CallLog) {
    let sb = NAV_HANDLER.mainSB
    let vc = sb.instantiateViewControllerWithIdentifier(Identifier.callLogVC) as! CallLogsVC
    vc.callLog = callLog
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func smsContactFromCallLog(callLog:CallLog) {
    pushSMSThreadScreenVC(callLog)
  }
  
  private func callContactFromCallLog(callLog:CallLog) {
    
    let callLogLocal = CallLog(value: callLog)
    callLogLocal.timeStamp = NSDate().timeIntervalSince1970
    
    let callLogInfo = CallLogInfo()
    callLogInfo.id = NSUUID().UUIDString
    callLogInfo.duration = "12"
    callLogInfo.status = StatusCallLog.dialed
    callLogInfo.timeStamp = NSDate().timeIntervalSince1970
    callLogInfo.threadId = callLog.threadId
    callLogLocal.callLogInfos.append(callLogInfo)
    
    DB_HANDLER.update(callLogLocal)
    
    
    pushCallScreenVC(callLog)
  }
  
  private func pushSMSThreadScreenVC(callLog:CallLog) {
    let messageThreadVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.messageThreadVC) as! MessageThreadVC
    
    messageThreadVC.recipientName = callLog.contactName
    messageThreadVC.recipientNumber = callLog.contactNumber
    messageThreadVC.threadId = callLog.contactNumber
    messageThreadVC.thumbImageData = callLog.photoThumbImage

    pushVCAndHideTabBar(messageThreadVC)
  }
  
  private func pushCallScreenVC(callLog:CallLog) {
    let callScreenVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.callScreenVC) as! CallScreenVC
    callScreenVC.callLog = callLog
    callScreenVC.isOpenModally = true
    
    NAV_HANDLER.getCurrentNavController().presentViewController(callScreenVC, animated: true, completion: nil)
  }
  
  private func pushVCAndHideTabBar(vc: UIViewController) {
    NAV_HANDLER.getCurrentNavController().pushViewController(vc, animated: true)
    self.tabBarController?.tabBar.hidden = true
  }
  
  
  // MARK: - Public
  func createActionSheetForACallLog(indexPath: NSIndexPath) {
    let call = getActiveCallLogAtIndexPathRow(indexPath)
    
    ALERT_HANDLER.createActionSheetWithMessage(call.contactName, actionOneTitle: Config.alertSendSMS, actionTwoTitle: Config.alertCall, actionThreeTitle:  Config.alertCallLog, cancelTitle: Config.alertCancel, withIndexPathRow: indexPath, andDelegate: self)
  }
  
  // MARK: - AlertViewHandlerDelegate
  func actionOne(indexPath: NSIndexPath) {
    let callLog = getActiveCallLogAtIndexPathRow(indexPath)
    smsContactFromCallLog(callLog)
  }
  
  func actionTwo(indexPath: NSIndexPath) {
    let callLog = getActiveCallLogAtIndexPathRow(indexPath)
    callContactFromCallLog(callLog)
  }
  
  func actionThree(indexPath: NSIndexPath) {
    let callLog = getActiveCallLogAtIndexPathRow(indexPath)
    openContactCallLogHistory(callLog)
  }
}