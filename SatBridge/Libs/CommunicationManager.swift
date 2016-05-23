//
//  CommunicationManager.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 4/28/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation



class CommunicationManager {
  
  var isConnected = false
  
  let connectionTimeOut = 1
  
  let client:TCPClient = TCPClient(addr: "www.apple.com", port: 80)
  let clientA:TCPClient = TCPClient(addr: "192.168.43.1", port: 4444)
  let clientSB:TCPClient = TCPClient(addr: "192.168.100.76", port: 5001)
  let clientIPhone:TCPClient = TCPClient(addr: "192.168.1.105", port: 5001)
  
  // MARK: - SB -
  func sbSignalStrenght() {
    let (success, errmsg) = clientSB.send(str:"AT+CSQ")
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func sbTest() {
    let (success, errmsg) = clientSB.send(str:"ATI" )
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func sbConnect() {
    let (success, errmsg) = clientSB.connect(timeout: connectionTimeOut)
    
    if success {
      listenForData(clientSB)
      isConnected = true
    }else {
      emoPrint(errmsg)
    }
    
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func sbDisconnect() {
    let (success, errormsg) = clientSB.close()
    isConnected = false
    
    emoPrint(success)
    emoPrint(errormsg)
  }
  
  
  // MARK: - ANDROID -
  func apConnect() {
    let (success, errmsg) = clientA.connect(timeout: connectionTimeOut)
    self.isConnected = true
    listenForData(clientA)
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func apDisconnect() {
    let (success, errmsg) = clientA.close()
    self.isConnected = false
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func apCall() {
    let testCallString = "+CLIP:381612223334,146"
    let (success, errmsg) = clientA.send(str:testCallString)
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func apSendSMS(pduString: String) {
    let finalString = "+CMT:,049\n" + pduString
    emoPrint(finalString)
    let (success, errmsg) = clientA.send(str:finalString)
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  
  // MARK: - WEB -
  func webConnect() {
    let (success, errmsg) = client.connect(timeout: 1)
    if success {
      isConnected = true
      listenForData(client)
    }
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func webDisconnect() {
    let (success, errormsg) = client.close()
    emoPrint(success)
    emoPrint(errormsg)
    
    isConnected = false
    emoPrint(isConnected)
  }
  
  
  func webSendReq() {
    let (success, errmsg) = client.send(str:"GET / HTTP/1.0\n\n" )
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  
  
  // MARK: - iPhone AP -
  func iPhoneAPConnect() {
    let (success, errmsg) = clientIPhone.connect(timeout: 1)
    
    if success {
      isConnected = true
      listenForData(clientIPhone)
    }
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  func iPhoneAPDisconnect() {
    let (success, errmsg) = clientIPhone.close()
    isConnected = false 
    emoPrint(success)
    emoPrint(errmsg)
  }
  
  
  func SendIPHONE() {
    //      let (success, errmsg) = client.send(str:"GET / HTTP/1.0\n\n" )
    let (success, errmsg) = clientIPhone.send(str:"GET PAJA" )
    
    if success {
      let data = clientIPhone.read(1024*10)
      if let d = data {
        if let str = NSString(bytes: d, length: d.count, encoding: NSUTF8StringEncoding) {
          print(str)
        }
      }
    }else {
      print(errmsg)
    }

  }
  
  func serverModeiPhone() {
    func echoService(client c:TCPClient) {
      print("newclient from:\(c.addr)[\(c.port)]")
      let d = c.read(1024*10)
      c.send(data: d!)
      c.close()
    }
    
    let server:TCPServer = TCPServer(addr: "192.168.1.105", port: 5001)
    let (success, msg) = server.listen()
    if success {
      while true {
        if let client = server.accept() {
          echoService(client: client)
        } else {
          print("accept error")
        }
      }
    } else {
      print(msg)
    }
  }
  
  // MARK: - Private -
  func listenForData(client:TCPClient) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
      while self.isConnected {
        //                print("LISTENING")
        let data = client.read(1024*10)
        if let d = data {
          //          if let str = String(bytes: d, encoding: NSUTF8StringEncoding) {
          if let str = NSString(bytes: d, length: d.count, encoding: NSUTF8StringEncoding) {
            emoPrint(str)
          }
          //          self.isConnected = false
        }
      }
    }
  }
}