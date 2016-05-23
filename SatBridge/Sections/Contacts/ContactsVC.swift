//
//  ContactsVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 193//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class ContactsVC: SBTableVC {

  // MARK: - Properties
  var contacts = [CNContact]()
  var contactsFiltered = [CNContact]()
  
  var contactsSectionTitles = [String]()
  var contactsFullNames = [String]()
  var contactsDictionary = [String: [CNContact]]()
  
  let searchController = UISearchController(searchResultsController: nil)
  
  var isOpenedModaly = false
  var isOpenedFromContainer = false 
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = navigationController {
      NAV_HANDLER.contactsNC = navigationController!
    }
  
    setupSearchController()
    getContactsAndSortThem()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    getContactsAndSortThem()
    self.tabBarController?.tabBar.hidden = false
  }
  
  deinit {
  //Apple iOS 9 bug fix - http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller
    searchController.loadViewIfNeeded()
  }
  
  
  // MARK: - Actions
  @IBAction func refreshContactsAction(sender: UIBarButtonItem) {
    getContactsAndSortThem()
    tableView.reloadData()
  }
  
  @IBAction func addContact(sender: AnyObject) {
    let controller = CONTACTS_HANDLER.createContactVC()
    controller.delegate = self
    self.navigationController?.pushViewController(controller, animated: true)
    self.tabBarController?.tabBar.hidden = true
  }
}