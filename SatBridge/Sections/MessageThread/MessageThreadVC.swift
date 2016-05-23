//
//  MessageThreadVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 124//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Contacts

class MessageThreadVC: SBTableVC {
  
  @IBOutlet weak var topTVConstraint: NSLayoutConstraint!
  @IBOutlet weak var textBubble: UITextField!

  // MARK: - Properties
  var recipientNumber = ""
  var recipientName = ""
  var threadId = ""
  var thumbImageData: NSData?
  
  var originalKeyboardSizeHeight = CGFloat(0.0)
  var messageThread = [Message]()
  
  let navBarImageFrame = CGRectMake(0, 0, 40, 40)

  // TODO: MOC Counter to simulate correspondence - Remove when not needed anymore
  var counter = 0

  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationBarImage()
    setKeyboardObservers()
    setElementsAndBehaviours()
    getMessagesFromDB()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    scrollTableViewToBottom()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  
  // MARK: - Private]
  private func setNavigationBarImage() {
    let image = UIImageView(frame: navBarImageFrame)
    image.contentMode = UIViewContentMode.ScaleAspectFit
    image.layer.cornerRadius = navBarImageFrame.size.width/2
    image.layer.masksToBounds = true
    
    if let imageData = thumbImageData {
      let imageThumb = UIImage(data: imageData)
      let imageScaled = resizeImage(imageThumb!, newWidth: 40.0)
      image.image = imageScaled
    } else {
      let imageScaled = resizeImage(UIImage(named: Images.defaultMssgThreadImage)!, newWidth: 40.0)
      image.image = imageScaled
    }
    
    self.navigationItem.titleView = image
  }
  
  private func getMessagesFromDB() {
    
    if let listOfMssgs = DB_HANDLER.getMssgThreadForPK(threadId) {
      messageThread = Array(listOfMssgs.messages)      
    }
  }
  
  private func scrollTableViewToBottom() {
    if self.messageThread.count > 0 {
      self.tableView.scrollToBottomAnimated(false, delay: 0.1 * Double(NSEC_PER_SEC))
    }
  }
  
  private func setElementsAndBehaviours() {
    self.navigationItem.title = recipientName
    textBubble.delegate = self
    self.hideKeyboardWhenTappedAround()
  }
  
  private func setKeyboardObservers() {
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector: #selector(self.keyboardWillShow(_:)),
                                                     name: UIKeyboardWillShowNotification,
                                                     object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self,
                                                     selector: #selector(self.keyboardWillHide(_:)),
                                                     name: UIKeyboardWillHideNotification,
                                                     object: nil)

  }
  
  
  // MARK: - Public
  func keyboardWillShow(sender: NSNotification) {
    if let keyboardSize = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
      self.topTVConstraint.constant = keyboardSize.height
      self.view.frame.origin.y = -keyboardSize.height

      scrollTableViewToBottom()

    }
  }
  
  func keyboardWillHide(sender: NSNotification) {
    self.topTVConstraint.constant = 0
    self.view.frame.origin.y = 0
  }
  
  
  // MARK: - Actions
  @IBAction func sendMessage(sender: AnyObject) {

    // Create individual Message
    let m = Message()
    // Create standalone message
    m.id = NSUUID().UUIDString
    m.timeStamp = NSDate().timeIntervalSince1970
    m.message = textBubble.text!
    m.isNew = false
    m.isGroup = false
    if self.counter%2 == 0 {
      m.status = "Sent"
    } else {
      m.status = "Received"
    }
    
    // Add message to messages
    
    // Check if Mssg Thread is in DB and update it
    if let mssgExisting = DB_HANDLER.getMssgThreadForPK(threadId) {
      
      let mssgs = Messages(value: mssgExisting)
      mssgs.timeStamp = NSDate().timeIntervalSince1970
      mssgs.status = m.status
      mssgs.message = m.message
      mssgs.messages.append(m)
      
      DB_HANDLER.update(mssgs)

    } else {
    // If Mssg Thread not in DB, create it.
      let mssgs = Messages()
      mssgs.id = threadId
      mssgs.senderNumber = ""
      mssgs.senderName = ""
      mssgs.recipientNumber = recipientNumber
      mssgs.recipientName = recipientName
      mssgs.threadId = threadId
      mssgs.timeStamp = NSDate().timeIntervalSince1970
      mssgs.status = m.status
      mssgs.message = m.message
      mssgs.messages.append(m)
      mssgs.photoThumbImage = thumbImageData
      
      DB_HANDLER.add(mssgs)
    }

    messageThread.append(m)
  }
}


// Mark: - Extensions
extension MessageThreadVC: UITextFieldDelegate {

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == textBubble {
      
      if textField.text?.characters.count > 0 {
        sendMessage(textField)
        
        tableView.reloadData()
        tableView.scrollToBottom(false)
        
        textField.text = ""
        
        // TODO: - Remove MOC Counter when Logic for SMS implemented
        self.counter += 1
      }
      
      return false
    }
    
    return true
  }
}