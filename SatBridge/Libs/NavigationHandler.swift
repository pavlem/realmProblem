//
//  NavigationHandler.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/18/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

class NavigationHandler {
  
  func getCurrentNavController() -> UINavigationController {
    let mainTabBarController = UIApplication.sharedApplication().keyWindow?.rootViewController as! MainTBC
    return mainTabBarController.selectedViewController as! UINavigationController
  }
  
  
  func getCurrentViewController() -> UIViewController {
    return (UIApplication.sharedApplication().keyWindow?.rootViewController)!
  }
  
  lazy var inboxNC = UINavigationController()
  lazy var callsNC = UINavigationController()
  lazy var contactsNC = UINavigationController()
  lazy var moreNC = UINavigationController()

  
  lazy var mainSB = UIStoryboard(name: "Main", bundle: nil)
  
}