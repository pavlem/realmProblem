//
//  Login+iPhoneS.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 4/28/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC {
  
  @IBAction func connectToS(sender: UIButton) {
    COMM_HANDLER.iPhoneAPConnect()
  }
  
  @IBAction func closeToiPhoneS(sender: UIButton) {
    COMM_HANDLER.iPhoneAPDisconnect()
  }
  
  @IBAction func serverMode(sender: UIButton) {
    COMM_HANDLER.serverModeiPhone()
  }
}