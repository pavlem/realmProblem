//
//  LanguageVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/4/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class LanguageVC: SBTableVC {
  
  
//  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    UIApplication.sharedApplication().statusBarHidden = true
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    UIApplication.sharedApplication().statusBarHidden = false
  }
  
  // MARK: - Delegates
  // MARK: Table view data source
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return LocalizationHandler.availableLanguageDescriptions.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.languageCell, forIndexPath: indexPath)
      
      let supportedLanguagesDictionary = LocalizationHandler.availableLanguageDescriptions
      let supportedLanguagesAbbreviations = LocalizationHandler.availableLanguages
      let supportedLanguageAbbreviation = LocalizationHandler.availableLanguages[indexPath.row]
      let supportedLanguageName = supportedLanguagesDictionary[supportedLanguageAbbreviation]
      
      cell.textLabel?.text = supportedLanguageName
      
      if supportedLanguagesAbbreviations[indexPath.row] == DEFAULTS.stringForKey(userDefaultsKey_defaultLanguage) {
        cell.accessoryType = .Checkmark
      }
      
      return cell
  }
  
  
  // MARK:  UITableViewDelegate Methods
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    
    let visibleCells = tableView.visibleCells
    for cell in visibleCells {
      cell.accessoryType = .None
    }
    
    return indexPath
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    tableView.cellForRowAtIndexPath(indexPath)!.accessoryType = .Checkmark
    
    LocalizationHandler.sharedInstace.defaultLanguage = LocalizationHandler.availableLanguages[indexPath.row]
    
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}