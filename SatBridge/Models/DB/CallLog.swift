//
//  CallLog.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/24/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class CallLog: Object {
  
  dynamic var id = ""
  dynamic var contactNumber = ""
  dynamic var contactName = ""
  dynamic var photoUri = ""
  dynamic var threadId = ""   //contactNumber
  dynamic var timeStamp = 0.0
  dynamic var duration = "" //----- rmeove
  dynamic var status = "" //----- rmeove
  dynamic var photoThumbImage : NSData? = nil
  
  let callLogInfos = List<CallLogInfo>()

  override public class func primaryKey() -> String {
    return "id"
  }
}
