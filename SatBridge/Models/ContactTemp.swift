//
//  Contact.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/8/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation

struct ContactTemp {
  
  var firstName : String?
  var lastName : String?
  var email : String?
  
  init(firstName: String?, lastName: String?, email: String?) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }
}