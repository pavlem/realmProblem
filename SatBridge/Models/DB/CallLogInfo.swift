//
//  CallLogInfo.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 144//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class CallLogInfo: Object {
  
  dynamic var id = ""
  
  dynamic var timeStamp = 0.0
  dynamic var duration = ""
  dynamic var status = ""
  dynamic var threadId = ""
  
  override public class func primaryKey() -> String {
    return "id"
  }
}
