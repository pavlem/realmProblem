//
//  MoreVC+UIAlertController.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 154//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MoreVC: AlertViewHandlerDelegate {
  
  func alertActionOK(type: Int) {
    
    if type == AlertActionType.DeleteAllCallLogs.rawValue {
      DB_HANDLER.deleteCallLogObjects()
    } else if type == AlertActionType.DeleteAllMssgs.rawValue {
      DB_HANDLER.deleteAllMessages()
    }
  }
  
  func alertActionCancel() {
  }
  
  func createAlertForDeletingTheCallLogs() {
    ALERT_HANDLER.createAlertWithOKandCancelWithMessage("Are you sure", andTitle: "Delete All Call Logs", andDelegate: self, andType: AlertActionType.DeleteAllCallLogs.rawValue)
  }
  
  func createAlertForDeletingTheMssgs() {
    ALERT_HANDLER.createAlertWithOKandCancelWithMessage("Are you sure", andTitle: "Delete All Mssgs", andDelegate: self, andType: AlertActionType.DeleteAllMssgs.rawValue)
  }
}