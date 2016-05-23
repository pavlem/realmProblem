//
//  CallsVC+UITableViewDataSource.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension CallsVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return self.callsFiltered.count
    }
    
    return callsScope.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.callCell, forIndexPath: indexPath) as! CallCell
    var callLog = callsScope[indexPath.row]
    
    if searchController.active && searchController.searchBar.text != "" {
      callLog = callsFiltered[indexPath.row]
    } else {
      callLog = callsScope[indexPath.row]
    }

    cell.name.text = callLog.contactName
    let startDate = NSDate(timeIntervalSince1970: callLog.timeStamp)
    cell.date.text = getApropriateDateStringForDate(startDate)
    cell.status.text = callLog.status
    cell.totalCalls.text = "Total no: \(callLog.callLogInfos.count) "
    
    if let image = callLog.photoThumbImage {
      let imageJ = UIImage(data: image)
      cell.contactImage.image = imageJ
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      
      var callLog = CallLog()
      
      if searchController.active && searchController.searchBar.text != "" {
        callLog = callsFiltered[indexPath.row]
        callsFiltered.removeAtIndex(indexPath.row)
        
      } else {
        callLog = callsScope[indexPath.row]
      }
      
      let indAll = callsAll.indexOf {$0.id == callLog.id}
      let indScope = callsScope.indexOf {$0.id == callLog.id}
      
      callsAll.removeAtIndex(indAll!)
      callsScope.removeAtIndex(indScope!)
      
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
  }
}