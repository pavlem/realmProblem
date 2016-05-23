//
//  TechLog.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/3/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation

struct TechLogMOC {
  var infoMain: String?
  var infoHelp: String?
  var date: String?
  
  init(infoMain: String?, infoHelp: String?, date: String?) {
    self.infoMain = infoMain
    self.infoHelp = infoHelp
    self.date = date
  }
}