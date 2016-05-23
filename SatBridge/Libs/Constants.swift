//
//  Constants.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/25/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit


struct DeviceProperties {
  static let deviceWidth = UIApplication.sharedApplication().keyWindow?.frame.width
}

struct Images {
  static let defaultMssgThreadImage = "contactDefault"
}

struct Config {  
  static let deleteTableViewItemCalls = "deleteTableViewItemCalls".localized()
  static let deleteTableViewItemInbox = "deleteTableViewItemInbox".localized()
  
  static let alertSendSMS = "alertSendSMS".localized()
  static let alertCall = "alertCall".localized()
  static let alertCancel = "alertCancel".localized()
  static let alertCallLog = "alertCallLog".localized()
}

struct Identifier {
  static let messageThreadVC = "MessageThread_SB_ID"
  static let callScreenVC = "CallScreenVC_SB_ID"
  static let callLogVC = "CallLogsVC_SB_ID"
  static let multiNumberSelectionVC = "MultiNumberSelectionVC_SB_ID"
}

struct Segue {
  static let messageThread = "MessageThread_Segue"
  static let ContactsModal = "Contacts_Modal_Segue"
  static let ContactsContainer = "Contacts_Container_Segue"

  
  
}

struct CellIdentifier {
  static let messageThreadCellReceived = "MessageThreadCell_Received_ID"
  static let messageThreadCellSent = "MessageThreadCell_Sent_ID"
  static let techLogCell = "TechLogCell_ID"
  static let callCell = "CallCell_ID"
  static let contactCell = "ContactCell_ID"
  static let messageCell = "MessagesCell_ID"
  static let languageCell = "LanguageCell_ID"
  static let callLogCell = "CallLogCell_ID"
  static let multiSelectionCell = "MultiSelectionCell_ID"

}

struct StatusCallLog {
  static let all = "All"
  static let dialed = "Dialed"
  static let noAnswer = "No Answer"
  static let missed = "Missed"
  static let received = "Received"
  
  
  static let read = "Read" //TODO: Remove this after refactor
}

struct Color {
  static let SB_Background = UIColor(red: 25.0/255, green: 167.0/255, blue: 228.0/255, alpha: 1.0)
  static let SB_Delete = UIColor.redColor()
  static let receivedMssg = UIColor(red: 255.0/255, green: 204.0/255, blue: 102.0/255, alpha: 1.0)
  static let sentMssg = UIColor(red: 188.0/255, green: 239.0/255, blue: 255.0/255, alpha: 1.0)

}