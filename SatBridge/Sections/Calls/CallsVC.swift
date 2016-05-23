//
//  CallsVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 283//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import RealmSwift


class CallsVC: SBTableVC {
  
  // MARK: - Properties -
  var callsAll = [CallLog]()
  var callsScope = [CallLog]()
  var callsFiltered = [CallLog]()
  
  let dialerTransparency = CGFloat(0.3)
  let searchController = UISearchController(searchResultsController: nil)
  
  let defaultScopeIndex = 0
  let defaultScopeStart = StatusCallLog.all
  var lastActiveScopeIndex : Int?
  var lastActiveScopeString : String?
  
  
  @IBOutlet weak var scopeSegmentedControll: UISegmentedControl!
  @IBOutlet weak var dialView: UIView!
  
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = navigationController {
      NAV_HANDLER.callsNC = navigationController!
    }
    
    setupSearchController()
    setupElements()
  }
  
  override func viewWillAppear(animated: Bool) {
    self.tabBarController?.tabBar.hidden = false
    
    getCallLogsFromDB()
    setupDefaulSearchScope()
    self.tableView.reloadData()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    emptyCashData()
  }

  
  // MARK: - Private
  private func setupDefaulSearchScope() {
    
    if let scopeIndex = lastActiveScopeIndex {
      self.scopeSegmentedControll.selectedSegmentIndex = scopeIndex
      filterContentBasedOnScope(lastActiveScopeString!)

    } else {
      self.scopeSegmentedControll.selectedSegmentIndex = defaultScopeIndex
      filterContentBasedOnScope(defaultScopeStart)
    }
  }
  
  private func setupElements() {
    dialView.alpha = dialerTransparency
  }
  
  private func emptyCashData() {
    callsAll.removeAll()
    callsScope.removeAll()
  }
  
  private func getCallLogsFromDB() {
    let calls = DB_HANDLER.getObjectsForCallLogModel().sorted("timeStamp").reverse()
    for callLog in calls {
      callsAll.append(callLog)
    }
    callsScope = callsAll
  }
  
  
  // MARK: - Actions
  @IBAction func mocMissedAction(sender: UIBarButtonItem) {
    
    let pera = CallLog()
    pera.id = NSUUID().UUIDString
    pera.contactNumber = "62633333333"
    pera.contactName = "PERA"
    pera.status = StatusCallLog.missed
    
    let zika = CallLog()
    zika.id = NSUUID().UUIDString
    zika.contactNumber = "6262313333"
    zika.contactName = "ZIKA"
    zika.status = StatusCallLog.missed
    
    let realm = uiRealm
    
    try! realm.write {
      realm.add(pera)
      realm.add(zika)
    }
    
    self.tableView.reloadData()
  }
    
  @IBAction func mocNoAnsAction(sender: UIBarButtonItem) {
    
    let ana = CallLog()
    ana.id = NSUUID().UUIDString
    ana.contactNumber = "555"
    ana.contactName = "ANA"
    ana.status = StatusCallLog.noAnswer
    
    
    let jasna = CallLog()
    jasna.id = NSUUID().UUIDString
    jasna.contactNumber = "5555"
    jasna.contactName = "JASNA"
    jasna.status = StatusCallLog.noAnswer
    
    let realm = uiRealm
    try! realm.write {
      realm.add(ana)
      realm.add(jasna)
    }
    
    self.tableView.reloadData()
  }
  
  @IBAction func clearCalls() {
    callsAll.removeAll()
    callsScope.removeAll()
    callsFiltered.removeAll()
    tableView.reloadData()
    
    DB_HANDLER.deleteCallLogObjects()
  }
  
  @IBAction func scopeSegmentedControllAction(sender: UISegmentedControl) {
    
    var callScope = String()
    
    switch sender.selectedSegmentIndex {
    case 0:
      callScope = StatusCallLog.all
    case 1:
      callScope = StatusCallLog.dialed
    case 2:
      callScope = StatusCallLog.noAnswer
    case 3:
      callScope = StatusCallLog.received
    case 4:
      callScope = StatusCallLog.missed
    default:
      callScope = ""
    }
    
    lastActiveScopeIndex = sender.selectedSegmentIndex
    lastActiveScopeString = callScope
    
    filterContentBasedOnScope(callScope)
  }
}