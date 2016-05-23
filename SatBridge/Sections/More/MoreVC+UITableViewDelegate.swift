//
//  MoreVC+UITableViewDelegate.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/15/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension MoreVC {
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    let clickedCell = self.tableView.cellForRowAtIndexPath(indexPath)
    
    if clickedCell == newContactCell {
      let controller = CONTACTS_HANDLER.createContactVC()
      controller.delegate = self
      self.navigationController?.pushViewController(controller, animated: true)
      self.tabBarController?.tabBar.hidden = true
      
    } else if clickedCell == deleteCallLogsCell {
      
      createAlertForDeletingTheCallLogs()
      
    } else if clickedCell == deleteAllMssgs {
      
      createAlertForDeletingTheMssgs()
    }
  }
}
