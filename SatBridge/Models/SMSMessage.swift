//
//  SMSMessage.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/21/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation

struct SMSMessage {
  var fullName : String?
  var phoneNumber : String?
  var category : String?
  var imageData: NSData?
  var date: String?
  
  init(fullName: String, phoneNumber: String, category: String) {
    self.fullName = fullName
    self.phoneNumber = phoneNumber
    self.category = category
  }
}