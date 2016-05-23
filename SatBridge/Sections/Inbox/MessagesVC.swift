//
//  MessagesVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 84//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import Contacts

class MessagesVC: SBTableVC {
  
  // MARK: - Properties
  var messagesAll = [Messages]()
  var messagesScope = [Messages]()
  var messagesFiltered = [Messages]()
  let searchController = UISearchController(searchResultsController: nil)
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = navigationController {
      NAV_HANDLER.inboxNC = navigationController!
    }
    
    setupSearchController()
    getAllMessages()
  }
  
  override func viewWillAppear(animated: Bool) {
    
    self.tabBarController?.tabBar.hidden = false
    messagesAll.removeAll()
    messagesScope.removeAll()
    getAllMessages()
    self.tableView.reloadData()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if(segue.identifier == Segue.messageThread) {
      
      let cell = sender as! MessagesCell
      let indexPath = self.tableView.indexPathForCell(cell)
      
      var message = Messages()
      if searchController.active && searchController.searchBar.text != "" {
        message = messagesFiltered[(indexPath?.row)!]
      } else {
        message = messagesScope[indexPath!.row]
      }
      
      let messageThreadVC = (segue.destinationViewController as! MessageThreadVC)
      messageThreadVC.recipientName = message.recipientName
      messageThreadVC.threadId = message.id
      messageThreadVC.recipientNumber = message.recipientNumber
      messageThreadVC.thumbImageData = message.photoThumbImage
      
    } else if (segue.identifier == Segue.ContactsModal) {
      let contactsContainerVC = (segue.destinationViewController) as! ContactsContainerVC
      contactsContainerVC.isContactsOpenedModaly = true
    }
  }
  
  
  // MARK: - Actions 
  @IBAction func dellMessg(sender: UIBarButtonItem) {
    
    DB_HANDLER.deleteAllMessages()
    
    messagesAll.removeAll()
    messagesScope.removeAll()
    
    tableView.reloadData()
  }
  
  
  //MARK: - Private
  private func getAllMessages() {
    
    let mssgThreads = uiRealm.objects(Messages)
    messagesAll = Array(mssgThreads)
    messagesAll = messagesAll.sort {$0.timeStamp > $1.timeStamp}
    messagesScope = messagesAll
  }
}