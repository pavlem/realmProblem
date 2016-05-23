//
//  SettingsVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class SettingsVC: UITableViewController {
  
  @IBOutlet weak var connectionType: UISegmentedControl!
  @IBOutlet weak var modemType: UISegmentedControl!
  
  var settings = Settings()
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createOrRetreiveSettingsFromDB()
    setElements()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    createOrRetreiveSettingsFromDB()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    DB_HANDLER.update(settings)
  }
  
  
  // MARK: - Private
  private func setElements() {
    connectionType.selectedSegmentIndex = self.settings.connectionTypeSelectionIndex
    modemType.selectedSegmentIndex = self.settings.modemTypeSelectionIndex
  }
  
  private func createOrRetreiveSettingsFromDB() {
    if let settingsInfo = DB_HANDLER.getSettingsForPK("settingsObject_PK") {
      
      self.settings = Settings(value: settingsInfo)
      
    } else {
      
      self.settings.id = "settingsObject_PK"
      DB_HANDLER.add(self.settings)
    }
  }
  
  
  //MARK: - Actions
  @IBAction func connectionTypeAction(sender: UISegmentedControl) {
    self.settings.connectionTypeSelectionIndex = sender.selectedSegmentIndex
  }
  
  @IBAction func modemTypeAction(sender: UISegmentedControl) {
    self.settings.modemTypeSelectionIndex = sender.selectedSegmentIndex
  }
}