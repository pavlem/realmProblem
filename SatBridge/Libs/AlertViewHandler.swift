//
//  AlertViewHandler.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

enum AlertActionType: Int {
  case DeleteAllCallLogs = 0
  case DeleteAllMssgs = 1
}

@objc protocol AlertViewHandlerDelegate: class {
  optional func actionOne(indexPath: NSIndexPath)
  optional func actionTwo(indexPath: NSIndexPath)
  optional func actionThree(indexPath: NSIndexPath)
  
  optional func alertActionOK(type: Int)
  optional func alertActionCancel()
  
}

class AlertViewHandler {
  
  weak var alertDelegate: AlertViewHandlerDelegate?
  
  func createAlertWithOKandCancelWithMessage(message: String, andTitle title:String, andDelegate delegateVC: AlertViewHandlerDelegate, andType type: Int) {
    
    alertDelegate = delegateVC
    
    let refreshAlert = UIAlertController(title:title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
    
    refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
      self.alertDelegate?.alertActionOK!(type)
    }))
    
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
      self.alertDelegate?.alertActionCancel!()
    }))
    
    let currentVC = alertDelegate as! UIViewController
    currentVC.presentViewController(refreshAlert, animated: true, completion: nil)
  }
  

  func createActionSheetWithMessage(message: String, actionOneTitle: String, actionTwoTitle: String, actionThreeTitle: String?, cancelTitle: String, withIndexPathRow indexPath: NSIndexPath, andDelegate delegateVC: AlertViewHandlerDelegate) {
    
    alertDelegate = delegateVC
    
    // 1 - Create Alert VC
    let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .Alert)

    // 2 - Define actions
    let actionOne = UIAlertAction(title: actionOneTitle, style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      
      self.alertDelegate?.actionOne!(indexPath)
    })
    
    
    let actionTwo = UIAlertAction(title: actionTwoTitle, style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      
      self.alertDelegate?.actionTwo!(indexPath)
    })
    
    
    
    var actionThree = UIAlertAction()
    if actionThreeTitle?.characters.count > 0 {
      actionThree = UIAlertAction(title: actionThreeTitle, style: .Default, handler: {
        (alert: UIAlertAction!) -> Void in
        
        self.alertDelegate?.actionThree!(indexPath)
      })
    }
    
    // 3 - Define cancel
    let cancelAction = UIAlertAction(title: cancelTitle, style: .Cancel, handler: {
      (alert: UIAlertAction!) -> Void in
    })
    
    // 4 - Add actions
    optionMenu.addAction(actionOne)
    optionMenu.addAction(actionTwo)
    
    if actionThreeTitle?.characters.count > 0 {
      optionMenu.addAction(actionThree)
    }
    
    optionMenu.addAction(cancelAction)
    
    // 5 - Present it on screen
    let currentVC = alertDelegate as! UIViewController
    currentVC.presentViewController(optionMenu, animated: true, completion: nil)
  }
  
  func createAlertNotification(message: String, title: String, cancelButtonTitle: String, andDelegate delegateVC: AlertViewHandlerDelegate) {
    
    alertDelegate = delegateVC
    
    let currentVC = alertDelegate as! UIViewController

    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler:nil)
    alert.addAction(cancelAction)
  
    currentVC.presentViewController(alert, animated: true, completion: nil)
  }

  
  func createAlertNotification(message: String, title: String, cancelButtonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler:nil)
    alert.addAction(cancelAction)

    UIApplication.sharedApplication().keyWindow?.rootViewController!.presentViewController(alert, animated: true, completion: nil)
  }
}
