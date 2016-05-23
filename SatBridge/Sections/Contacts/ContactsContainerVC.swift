//
//  ContactsContainerVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 253//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class ContactsContainerVC: UIViewController {

  // MARK: - Properties
  var isContactsOpenedModaly = false
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepareForSegue(segue:(UIStoryboardSegue!), sender:AnyObject!) {
    if (segue.identifier == Segue.ContactsContainer)
    {
      let contacts = segue!.destinationViewController as! ContactsVC
      contacts.isOpenedModaly = true
      contacts.isOpenedFromContainer = true
    }
  }
  
  
  // MARK: - Actions
  @IBAction func cancelAction(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
}
