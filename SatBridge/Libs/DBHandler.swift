//
//  DBHandler.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

// Share Realm object across all Swift files
var uiRealm = try! Realm()
var settingsRealm = Settings()



class DBHandler {
  
  func getRealmConfiguration () {
    
    let config = Realm.Configuration()
    // Set as the configuration used for the default Realm
    Realm.Configuration.defaultConfiguration = config
  }
  
  // MARK: Write
  func clearAllData(){
    try! uiRealm.write {
      uiRealm.deleteAll()
    }
  }
  
  // MARK: - Private
  func update(dbObject: Object) {
    getRealmConfiguration()
    
    let realm = uiRealm
    
    do {
      try realm.write {
        realm.add(dbObject, update: true)
        
      }
    } catch {
      self.dbAlertFeedback("DB_Update_Failed")
    }
  }
  
  func checkForPrimaryKey(key: String) {
    let realm = uiRealm
    realm.objectForPrimaryKey(Object.self, key:key)
  }
  
  func deleteRealmClassesFromDB(customClass: Object.Type) {
    try! uiRealm.write {
      uiRealm.delete(uiRealm.objects(customClass))
    }
  }
  
  func add(dbObject: Object) {
    getRealmConfiguration()
    
    let realm = uiRealm
    
    do {
      try realm.write {
        realm.add(dbObject)
      }
    } catch {
      self.dbAlertFeedback("DB_Write_Failed")
    }
  }
  
  func delete(dbObject: Object) {
    getRealmConfiguration()
    
    let realm = uiRealm
    
    do {
      try realm.write {
        realm.delete(dbObject)
      }
    } catch {
      self.dbAlertFeedback("DB_Delete_Failed")
    }
  }
  
  func dbAlertFeedback(message: String) {
    self.dbAlertFeedback("DBAlertTitle", message: message, buttonTitle: "DBAlertButtonTitle")
  }
  
  func dbAlertFeedback(title:String, message:String, buttonTitle: String) {
    ALERT_HANDLER.createAlertNotification(message, title: title, cancelButtonTitle: buttonTitle)
  }
}