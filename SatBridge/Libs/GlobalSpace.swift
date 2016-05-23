//
//  GlobalSpace.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

let DB_HANDLER = GlobalSpace.sharedObject.dbHandler
let NAV_HANDLER = GlobalSpace.sharedObject.navigationHandler
let ALERT_HANDLER = GlobalSpace.sharedObject.alertHandler
let CONTACTS_HANDLER = GlobalSpace.sharedObject.contactsHandler
let COMM_HANDLER = GlobalSpace.sharedObject.communicationManager

class GlobalSpace {
 
  static let sharedObject = GlobalSpace()
  private init() {}
  
  // MARK: - Global Properties
  lazy var dbHandler = DBHandler()
  lazy var navigationHandler = NavigationHandler()
  lazy var alertHandler = AlertViewHandler()
  lazy var contactsHandler = ContactsHandler()
  lazy var communicationManager = CommunicationManager()
}


