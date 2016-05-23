//
//  TechLog.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/24/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class TechLog: Object {
  
  dynamic var timestamp = ""
  dynamic var type = ""
  dynamic var module = ""
  dynamic var logDescription = ""
  
  override public class func primaryKey() -> String {
    return "timestamp"
  }
}
