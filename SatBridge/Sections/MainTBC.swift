//
//  MainTBC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/16/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController {
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tabBar.barTintColor = Color.SB_Background
    self.tabBar.tintColor = UIColor.whiteColor()
    
    setTabBarTitles()
  }
  
  private func setTabBarTitles() {
    let item0 = self.tabBar.items![0]
    let item1 = self.tabBar.items![1]
    let item2 = self.tabBar.items![2]
    let item3 = self.tabBar.items![3]
    
    item0.title = "tabBarInbox".localized()
    item1.title = "tabBarCalls".localized()
    item2.title = "tabBarContacts".localized()
    item3.title = "tabBarMore".localized()
  }
}
