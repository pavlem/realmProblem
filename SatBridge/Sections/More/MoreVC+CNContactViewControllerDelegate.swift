//
//  MoreVC+CNContactViewControllerDelegate.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/15/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import ContactsUI

extension MoreVC: CNContactViewControllerDelegate {
    
  // MARK: - CNContactViewControllerDelegate
  func contactViewController(vc: CNContactViewController, didCompleteWithContact con: CNContact?) {
    self.tabBarController?.tabBar.hidden = false
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  func contactViewController(vc: CNContactViewController, shouldPerformDefaultActionForContactProperty prop: CNContactProperty) -> Bool {
    return false
  }
}