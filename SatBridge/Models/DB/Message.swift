//
//  Message.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 154//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class Message: Object {
  
  dynamic var id = ""
//  dynamic var threadId = ""
  dynamic var timeStamp = 0.0
  dynamic var message = ""
  dynamic var isNew = false
  dynamic var isGroup = false
  dynamic var status = ""
  
//  override class func primaryKey() -> String {
//    return "id"
//  }

}
