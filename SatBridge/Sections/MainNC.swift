//
//  MainNC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/23/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MainNC: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavBarDesign()
  }
  
  private func setNavBarDesign() {
    self.navigationBar.barTintColor = Color.SB_Background
    self.navigationBar.tintColor = UIColor.whiteColor()
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
  }
}
