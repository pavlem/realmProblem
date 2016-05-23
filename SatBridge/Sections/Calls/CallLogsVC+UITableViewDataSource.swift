//
//  CallLogsVC+UITableViewDataSource.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 184//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension CallLogsVC: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return callLogInfosScope.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.callLogCell, forIndexPath: indexPath) as! CallLogCell
    let callLogInfo = callLogInfosScope[indexPath.row]
    
    cell.status.text = callLogInfo.status
    cell.duration.text = callLogInfo.duration
    let startDate = NSDate(timeIntervalSince1970: callLogInfo.timeStamp)
    cell.timeStamp.text = getApropriateDateStringForDate(startDate)
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if (editingStyle == UITableViewCellEditingStyle.Delete) {
      
      let callLogInfo = callLogInfos[indexPath.row]
      let indexOf = callLogInfos.indexOf {$0.id == callLogInfo.id}
      
      callLogInfos.removeAtIndex(indexOf!)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
  }
}