//
//  MoreVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController {
  
  // MARK: - Properties
  @IBOutlet weak var newContactCell: UITableViewCell!
  @IBOutlet weak var deleteCallLogsCell: UITableViewCell!
  @IBOutlet weak var deleteAllMssgs: UITableViewCell!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = navigationController {
      NAV_HANDLER.moreNC = navigationController!
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.hidden = false
  }
}

