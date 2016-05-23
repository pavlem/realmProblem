//
//  MessageThreadVC+UITableViewDelegate.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 194//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MessageThreadVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    let m = messageThread[indexPath.row]
    
    let deleteButton = UITableViewRowAction(style: .Default, title: Config.deleteTableViewItemInbox, handler: { (action, indexPath) in
      self.tableView.dataSource?.tableView?(
        self.tableView,
        commitEditingStyle: .Delete,
        forRowAtIndexPath: indexPath
      )
      
      DB_HANDLER.delete(m)
      
      return
    })
    
    deleteButton.backgroundColor = Color.SB_Delete
    
    return [deleteButton]
  }
}