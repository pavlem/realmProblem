//
//  MessagesVC+UITableViewDataSource.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 84//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit


extension MessagesVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return self.messagesFiltered.count
    }
    return messagesScope.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.messageCell, forIndexPath: indexPath) as! MessagesCell
    var messageThread = messagesScope[indexPath.row]
    
    if searchController.active && searchController.searchBar.text != "" {
      messageThread = messagesFiltered[indexPath.row]
    } else {
      messageThread = messagesScope[indexPath.row]
    }
    
    cell.name.text = messageThread.recipientName
    cell.message.text = messageThread.message
    let startDate = NSDate(timeIntervalSince1970: messageThread.timeStamp)
    cell.date.text = getApropriateDateStringForDate(startDate)
    cell.status.text = messageThread.status

    
    if let imageData = messageThread.photoThumbImage {
      let imageThumb = UIImage(data: imageData)
      let imageScaled = resizeImage(imageThumb!, newWidth: 40.0)
      cell.avatar.image = imageScaled
    } else {
      let imageScaled = resizeImage(UIImage(named: Images.defaultMssgThreadImage)!, newWidth: 40.0)
      cell.avatar.image = imageScaled
    }
        
    return cell
  }
  
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      
      var messageThread = Messages()
      
      if searchController.active && searchController.searchBar.text != "" {
        messageThread = messagesFiltered[indexPath.row]
        messagesFiltered.removeAtIndex(indexPath.row)
        
      } else {
        messageThread = messagesScope[indexPath.row]
      }
      
      let indAll = messagesAll.indexOf {$0.senderNumber == messageThread.senderNumber}
      let indScope = messagesScope.indexOf {$0.senderNumber == messageThread.senderNumber}
      
      messagesAll.removeAtIndex(indAll!)
      messagesScope.removeAtIndex(indScope!)
      
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
  }
}