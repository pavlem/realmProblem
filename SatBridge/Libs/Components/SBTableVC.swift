//
//  SBTableVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/16/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class SBTableVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  // MARK: - Private
  func setupTableView() {
    tableView.estimatedRowHeight = 68.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.tableFooterView = UIView(frame: CGRectZero)
    tableView.tableFooterView!.hidden = true
    tableView.backgroundColor = UIColor.whiteColor()
  }
}


