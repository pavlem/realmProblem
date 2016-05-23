//
//  CallsVC+UITableViewDelegate.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension CallsVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    createActionSheetForACallLog(indexPath)
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    let callLog = self.getActiveCallLogAtIndexPathRow(indexPath)
    
    let deleteButton = UITableViewRowAction(style: .Default, title: Config.deleteTableViewItemCalls, handler: { (action, indexPath) in
      self.tableView.dataSource?.tableView?(
        self.tableView,
        commitEditingStyle: .Delete,
        forRowAtIndexPath: indexPath
      )      
      
      self.deleteCallLogAndRelatedCallLogInfos(callLog)
      
      return
    })
    
    deleteButton.backgroundColor = Color.SB_Delete
    
    return [deleteButton]
  }
  
  func deleteCallLogAndRelatedCallLogInfos(callLog: CallLog) {
    let callLogInfos = callLog.callLogInfos
    
    for callLogInfo in callLogInfos {
      DB_HANDLER.delete(callLogInfo)
    }
    
    DB_HANDLER.delete(callLog)
  }
}