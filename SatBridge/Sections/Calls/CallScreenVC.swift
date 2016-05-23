//
//  CallScreenVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts

class CallScreenVC: UIViewController {
  
  
  // MARK: - Properties
  @IBOutlet weak var contactImage: UIImageView!
  @IBOutlet weak var contactName: UILabel!
  @IBOutlet weak var contactNumber: UILabel!
  
  var isOpenModally = false
  var isOpenedFromContainer = false
  var callLog = CallLog()
  var myTimer = NSTimer()
  
  let MOCTimeInterval = 2.5
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setContactDetails()
    setElements()
    simulateMissedCall()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    myTimer.invalidate()
  }
  
  
  // MARK: - Private
  func simulateMissedCall() {
    myTimer = NSTimer.scheduledTimerWithTimeInterval(MOCTimeInterval, target: self, selector: #selector(CallScreenVC.closeScreen), userInfo: nil, repeats: true)
  }
  
  func closeScreen(sender: NSTimer) {
    
    let callLogLocal = CallLog(value: self.callLog)
    callLogLocal.status = StatusCallLog.noAnswer
    callLogLocal.timeStamp = NSDate().timeIntervalSince1970
    
    let callLogInfo = CallLogInfo()
    callLogInfo.duration = "12"
    callLogInfo.id = NSUUID().UUIDString
    callLogInfo.status = StatusCallLog.noAnswer
    callLogInfo.timeStamp = NSDate().timeIntervalSince1970
    callLogInfo.threadId = callLog.threadId
    callLogLocal.callLogInfos.append(callLogInfo)
    
    DB_HANDLER.update(callLogLocal)
    
    if isOpenModally {
      if isOpenedFromContainer {
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
      } else {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    } else {
      self.navigationController?.popViewControllerAnimated(true)
    }
  }
  
  
  // MARK: - Private
  private func setElements() {
    contactImage.layer.cornerRadius = contactImage.frame.width/2
    contactImage.layer.masksToBounds = true
  }
  
  private func setContactDetails() {
    if let imageData = callLog.photoThumbImage {
      contactImage.image = UIImage(data: imageData)
    }
    contactNumber.text = callLog.contactNumber
    contactName.text = callLog.contactName
  }
  
  
  // MARK: - Actions
  @IBAction func cancelCallAction(sender: UIButton) {
    if isOpenModally {
      if isOpenedFromContainer {
        self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
      } else {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    } else {
      self.navigationController?.popViewControllerAnimated(true)
    }
  }
}