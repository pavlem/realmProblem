//
//  Communicator.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 4/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

var readStream : CFWriteStreamRef?
var writeStream : CFWriteStreamRef?

var inputStream: NSInputStream?
var outputStream: NSOutputStream?


class Communicator : NSObject, NSStreamDelegate {
  
  static let sharedInstance = Communicator()

//  let serverAddress: CFString = "127.0.0.1"
  let serverAddress: CFString = "www.apple.com"

  let serverPort: UInt32 = 80
  
  private var inputStream: NSInputStream!
  private var outputStream: NSOutputStream!
  
  func connect() {
    print("connecting...")
    
    var readStream:  Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    
    CFStreamCreatePairWithSocketToHost(nil, self.serverAddress, self.serverPort, &readStream, &writeStream)
    
    // Documentation suggests readStream and writeStream can be assumed to
    // be non-nil. If you believe otherwise, you can test if either is nil
    // and implement whatever error-handling you wish.
    
    self.inputStream = readStream!.takeRetainedValue()
    self.outputStream = writeStream!.takeRetainedValue()
    
    self.inputStream.delegate = self
    self.outputStream.delegate = self
    
    self.inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    self.outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    
    self.inputStream.open()
    self.outputStream.open()
  }
  
  func stream(stream: NSStream, handleEvent eventCode: NSStreamEvent) {
    print("stream event")
    print(stream)
  }
}