//
//  Messages.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/24/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class Messages: Object {
  
  dynamic var id = ""
  dynamic var senderNumber = ""
  dynamic var senderName = ""
  dynamic var recipientNumber = ""
  dynamic var recipientName = ""
//  dynamic var photoUri = ""
  dynamic var threadId = ""
  dynamic var timeStamp = 0.0
  dynamic var message = ""
//  dynamic var isNew = false
//  dynamic var isGroup = false
  dynamic var status = ""
  dynamic var photoThumbImage : NSData? = nil
  
  let messages = List<Message>()

  override public class func primaryKey() -> String {
    return "id"
  }
}


