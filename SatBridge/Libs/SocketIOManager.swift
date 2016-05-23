//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by Gabriel Theodoropoulos on 1/31/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject, AlertViewHandlerDelegate {
  static let sharedInstance = SocketIOManager()
  
  var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.62:3000")!)
//  var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.43.1:4444")!)
//  var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.100.76:5001")!)

  override init() {
    super.init()
  }
  
  func establishConnection() {
    socket.connect()
    
    socket.onAny { data in
      emoPrint(data)
    }
    
    socket.on("connect") {data, ack in
      emoPrint("socket connected")
      self.showFeedbackInfo("socket connected")
    }
  }
  
  func closeConnection() {
    socket.disconnect()
    
    socket.on("disconnect") {data, ack in
      emoPrint("socket disconnect")
      self.showFeedbackInfo("socket disconnect")
    }
  }
  
  
  func receiveMssg(exitMssg: String) {
    socket.onAny { data in
      emoPrint(data)
    }
  }
 
  
  func listening() {
    socket.onAny { data in
      emoPrint(data)
    }
  }
  
  func sendMssg(stringData: String) {
    socket.emit("exitUser", stringData)
//    socket.emit(stringData)
  }
  
  
  func establishConnectionWithTimeout(int: Int) {
    
    socket.connect(timeoutAfter: int) {
      emoPrint("Nije uspelo")
      self.showFeedbackInfo("Nije uspelo")
    }
    
    socket.on("connect") {data, ack in
      emoPrint("socket connected")
      self.showFeedbackInfo("socket connected")
    }
  }
  
  func connectToServerWithNickname(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void) {
    socket.emit("connectUser", nickname)
    
    socket.on("userList") { ( dataArray, ack) -> Void in
      completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
    }
    
    listenForOtherMessages()
  }
  
  func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
    socket.emit("exitUser", nickname)
    completionHandler()
  }
  
  func sendMessage(message: String, withNickname nickname: String) {
    socket.emit("chatMessage", nickname, message)
  }
  
  func getChatMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
    socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
      var messageDictionary = [String: AnyObject]()
      messageDictionary["nickname"] = dataArray[0] as! String
      messageDictionary["message"] = dataArray[1] as! String
      messageDictionary["date"] = dataArray[2] as! String
      
      completionHandler(messageInfo: messageDictionary)
    }
  }
  
  private func listenForOtherMessages() {
    socket.on("userConnectUpdate") { (dataArray, socketAck) -> Void in
      NSNotificationCenter.defaultCenter().postNotificationName("userWasConnectedNotification", object: dataArray[0] as! [String: AnyObject])
    }
    
    socket.on("userExitUpdate") { (dataArray, socketAck) -> Void in
      NSNotificationCenter.defaultCenter().postNotificationName("userWasDisconnectedNotification", object: dataArray[0] as! String)
    }
    
    socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
      NSNotificationCenter.defaultCenter().postNotificationName("userTypingNotification", object: dataArray[0] as? [String: AnyObject])
    }
  }
  
  func sendStartTypingMessage(nickname: String) {
    socket.emit("startType", nickname)
  }
  
  func sendStopTypingMessage(nickname: String) {
    socket.emit("stopType", nickname)
  }
  
  // MARK: - ALERTS -
  private func showFeedbackInfo(feedbackInfo: String) {
    let refreshAlert = UIAlertController(title:"TITLE", message:feedbackInfo, preferredStyle: UIAlertControllerStyle.Alert)
    refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
    }))
    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
    }))
    NAV_HANDLER.getCurrentViewController().presentViewController(refreshAlert, animated: true, completion: nil)
  }
}