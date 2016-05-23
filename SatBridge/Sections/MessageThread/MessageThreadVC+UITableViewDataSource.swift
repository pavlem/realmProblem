//
//  MessageThreadVC+UITableViewDataSource.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 124//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MessageThreadVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return messageThread.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let mssg = messageThread[indexPath.row]
    
    var cellID = ""
    if mssg.status == "Sent" {
      cellID = CellIdentifier.messageThreadCellSent
    } else {
      cellID = CellIdentifier.messageThreadCellReceived
    }
    
    let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! MessageThreadCell
    cell.message.text = messageThread[indexPath.row].message
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      messageThread.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
  }
}

