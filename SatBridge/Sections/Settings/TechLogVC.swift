//
//  TechLogVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/3/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class TechLogVC: UITableViewController {
  
  var techLogs = techLogsMOCData
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Table view itself
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 68.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView(frame: CGRectZero)
    tableView.tableFooterView!.hidden = true
    tableView.backgroundColor = UIColor.whiteColor()
  }

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return techLogs.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.techLogCell, forIndexPath: indexPath) as! TechLogCell
      
      let techLog = techLogs[indexPath.row]
      cell.techLog = techLog
      
      return cell
  }
  
}
