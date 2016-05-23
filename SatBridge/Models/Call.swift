//
//  Call.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 213//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation

struct Call {
  var fullName : String?
  var phoneNumber : String?
  var status : String?
  var imageData: NSData?
  var date: String?
  
  init(fullName: String, phoneNumber: String, status: String) {
    self.fullName = fullName
    self.phoneNumber = phoneNumber
    self.status = status
  }
}