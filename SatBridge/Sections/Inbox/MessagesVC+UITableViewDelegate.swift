//
//  MessagesVC+UITableViewDelegate.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 84//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MessagesVC: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    self.tabBarController?.tabBar.hidden = true
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    var messageThread = Messages()
    if searchController.active && searchController.searchBar.text != "" {
      messageThread = messagesFiltered[indexPath.row]
    } else {
      messageThread = messagesScope[indexPath.row]
    }
    
    let deleteButton = UITableViewRowAction(style: .Default, title: Config.deleteTableViewItemInbox, handler: { (action, indexPath) in
      self.tableView.dataSource?.tableView?(
        self.tableView,
        commitEditingStyle: .Delete,
        forRowAtIndexPath: indexPath
      )
      
      if let mssgThread = DB_HANDLER.getMssgThreadForPK(messageThread.id) {
        for m in mssgThread.messages {
          DB_HANDLER.delete(m)
        }
        DB_HANDLER.delete(mssgThread)
      }
      
      return
    })
    
    deleteButton.backgroundColor = Color.SB_Delete
    
    return [deleteButton]
  }
}
