//
//  DeveloperVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/2/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class DeveloperVC: UITableViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var developerDeviceOption: UISegmentedControl!
  @IBOutlet weak var developerWiFiOpition: UISegmentedControl!
  @IBOutlet weak var developerServerClientOption: UISegmentedControl!
  
  var settings = Settings()
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.settings = DB_HANDLER.getCopyOfUniqueSettingsObjectFromDB()

    setElements()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.settings = DB_HANDLER.getCopyOfUniqueSettingsObjectFromDB()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    DB_HANDLER.update(settings)
  }
  
  
  // MARK: - Private
  private func setElements() {
    developerDeviceOption.selectedSegmentIndex = settings.developerDeviceOption
    developerWiFiOpition.selectedSegmentIndex = settings.developerWiFiOpition
    developerServerClientOption.selectedSegmentIndex = settings.developerServerClientOption
  }
  
  
  // MARK: - Actions
  @IBAction func devDeviceAction(sender: UISegmentedControl) {
    settings.developerDeviceOption = sender.selectedSegmentIndex
  }
  
  @IBAction func devWiFiAction(sender: UISegmentedControl) {
    settings.developerWiFiOpition = sender.selectedSegmentIndex
  }
  
  @IBAction func devServerAction(sender: UISegmentedControl) {
    settings.developerServerClientOption = sender.selectedSegmentIndex
  }
}