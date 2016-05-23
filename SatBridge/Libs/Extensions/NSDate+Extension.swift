//
//  NSDate+Extension.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 54//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation


extension NSDateFormatter {
  convenience init(dateFormat: String) {
    self.init()
    self.dateFormat = dateFormat
  }
}

extension NSDate {
  struct Date {
    static let formatterShortDate = NSDateFormatter(dateFormat: "dd-MM-yyyy")
    static let formatterHourMin = NSDateFormatter(dateFormat: "HH:mm")
  }
  
  
  var shortDate: String {
    return Date.formatterShortDate.stringFromDate(self)
  }
  
  var hourMinSec: String {
    return Date.formatterHourMin.stringFromDate(self)
  }
}