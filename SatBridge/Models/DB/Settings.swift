//
//  Settings.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public class Settings: Object {
  
  dynamic var id = ""
  dynamic var languageTest = ""
  dynamic var modemTypeSelectionIndex = 0
  dynamic var connectionTypeSelectionIndex = 0
  
  dynamic var developerDeviceOption = 0
  dynamic var developerWiFiOpition = 0
  dynamic var developerServerClientOption = 1

  
  // MARK: - Primary key
  override public class func primaryKey() -> String {
    return "id"
  }
}
