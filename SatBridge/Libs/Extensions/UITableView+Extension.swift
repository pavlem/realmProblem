//
//  TableView+Extension.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 124//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  func scrollToBottom(animated: Bool) {
    let sections = self.numberOfSections
    let rows = self.numberOfRowsInSection(sections - 1)
    self.scrollToRowAtIndexPath(NSIndexPath(forRow: rows - 1, inSection: sections - 1), atScrollPosition: .Bottom, animated: animated)
  }
  
  func scrollToBottomAnimated(animated: Bool, delay: Double ) {
    
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue(), {
      self.scrollToBottom(animated)
    })
  }
}
