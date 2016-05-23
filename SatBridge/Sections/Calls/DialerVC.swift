//
//  DialerVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 253//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import AudioToolbox


class DialerVC: UIViewController, CNContactViewControllerDelegate, AlertViewHandlerDelegate {
  
  // MARK: - Properties
  @IBOutlet weak var dialPad: UITextField!
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setElements()
  }
  

  // MARK: - Actions
  @IBAction func addToContacts(sender: UIButton) {
    
    if CONTACTS_HANDLER.getContactForCallScreen(dialPad.text!).isNumberInContacts {
      
      if let callLog = DB_HANDLER.getCallLogForPhoneNumber(dialPad.text!) {
        ALERT_HANDLER.createAlertNotification("\(callLog.contactName) is already in DB", title: "", cancelButtonTitle: "OK", andDelegate: self)
      }
      
    } else {
      let contactsController = CONTACTS_HANDLER.createContactVCWithPhoneNumber(dialPad.text!)
      contactsController.delegate = self
      let nc = UINavigationController(rootViewController: contactsController)
      self.presentViewController(nc, animated: true, completion: nil)
    }
  }
  
  @IBAction func closeDialer(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func dialButtonAction(sender: UIButton) {
    let digit = sender.currentTitle!
    dialPad.text = dialPad.text! + digit
    
    playSystemSoundForDigit(digit)
  }
  
  @IBAction func dialAction(sender: UIButton) {
    guard dialPad.text!.characters.count > 0 else {return}

    updateOrCreateCallLogInDB(dialPad.text!)
    
    openCallScreenWithContactInfoForCallLog(DB_HANDLER.getCallLogForPhoneNumber(dialPad.text!)!)
  }
  
  @IBAction func digitZeroLongPressAction(sender: UILongPressGestureRecognizer) {
    if sender.state == .Began {
      
      if dialPad.text?.characters.count == 0 {
        dialPad.text = dialPad.text! + "+"
      }
    }
  }
  
  @IBAction func backButtonAction(sender: UIButton) {
    if dialPad.text!.characters.count > 0 {
      dialPad.text = dialPad.text?.substringToIndex((dialPad.text?.endIndex.predecessor())!)
    }
  }
  
  
  // MARK: - Private
//  private func updateOrCreateCallLogForNumber(number: String) {
//    if let callLog = DB_HANDLER.getCallLogForPhoneNumber(number) {
//      DB_HANDLER.updateCallLogInDB(callLog)
//    } else {
//      DB_HANDLER.createCallLogInDB(dialPad.text!)
//    }
//  }
  
  private func openCallScreenWithContactInfoForCallLog(callLog: CallLog) {
    
    var contactForCallScreen = CNMutableContact()
    let contactTuple = CONTACTS_HANDLER.getContactForCallScreen(dialPad.text!)
    
    if contactTuple.isNumberInContacts {
      contactForCallScreen = contactTuple.cnContact!
    } else {
      contactForCallScreen.givenName = dialPad.text!
    }
    
    let callScreenVC = NAV_HANDLER.mainSB.instantiateViewControllerWithIdentifier(Identifier.callScreenVC) as! CallScreenVC
    callScreenVC.callLog = callLog
    callScreenVC.isOpenModally = true
    self.presentViewController(callScreenVC, animated: true, completion: nil)
  }
  
  private func setElements() {
    self.dialPad.inputView = UIView(frame: CGRectNull)  // UITextView - do not show keyboard
  }
  
  private func updateOrCreateCallLogInDB(number: String) {
    
    if let callLog = uiRealm.objectForPrimaryKey(CallLog.self, key: number) {
      
      let callLogLocal = CallLog(value: callLog)
      callLogLocal.status = StatusCallLog.dialed
      callLogLocal.timeStamp = NSDate().timeIntervalSince1970

      let callLogInfo = CallLogInfo()
      callLogInfo.id = NSUUID().UUIDString
      callLogInfo.duration = "12"
      callLogInfo.status = StatusCallLog.dialed
      callLogInfo.timeStamp = NSDate().timeIntervalSince1970
      callLogInfo.threadId = callLog.threadId
      callLogLocal.callLogInfos.append(callLogInfo)

      DB_HANDLER.update(callLogLocal)
      
    } else {
      let dialNumber = dialPad.text!
      
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
  }
  
  private func playSystemSoundForDigit(digit: String) {
    var toneIndex = -1
    
    if digit == "*" {
      toneIndex = 1210
    } else if digit == "#" {
      toneIndex = 1211
    } else {
      let intString = "120\(digit)"
      
      toneIndex = Int(intString)!
    }
    
    let soundID = SystemSoundID(toneIndex)
    AudioServicesPlaySystemSound(soundID)
  }
  
  // MARK: - CNContactViewControllerDelegate
  func contactViewController(vc: CNContactViewController, didCompleteWithContact con: CNContact?) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}