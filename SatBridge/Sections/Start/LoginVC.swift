//
//  LoginVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 2/26/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit
import Darwin.C



class LoginVC: UIViewController, NSStreamDelegate {
  

  
  
  // MARK: - Properties
  @IBOutlet weak var skip: UIButton!
  @IBOutlet weak var connect: UIButton!
  @IBOutlet weak var connectionActivity: UIActivityIndicatorView!
  
  var timerMOC: NSTimer?
  
  
  let clientIPhone:TCPClient = TCPClient(addr: "192.168.1.105", port: 5001)

  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    connectionActivity.hidden = true
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    setElements()
  }
  
  // MARK: - Actions
  @IBAction func connectToSatBridge(sender: AnyObject) {
    connectionActivity.hidden = false
    connectionActivity.hidesWhenStopped = true
    connectionActivity.startAnimating()
    
    //TODO: - Remove MOC Login when real implemented.
    if let _ = timerMOC {
      timerMOC!.invalidate()
    }
    timerMOC = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(LoginVC.openMainScreen(_:)), userInfo: nil, repeats: false)
  }
  
  @IBAction func setLanguage(sender: UIButton) {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let tbc = sb.instantiateViewControllerWithIdentifier("Language_VC")
    self.presentViewController(tbc, animated: true, completion: nil)
  }
  
  
  // MARK: public
  func openMainScreen(timer: NSTimer!) {
    connectionActivity.stopAnimating()
    openMainScreen()
  }
  
  
  // MARK: - Private
  private func setElements() {
    skip.setTitle("startScreenSkip".localized(), forState: UIControlState.Normal)
    connect.setTitle("startScreenConnect".localized(), forState: UIControlState.Normal)
  }
  
  private func openMainScreen() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let tbc = sb.instantiateViewControllerWithIdentifier("TabBar_ID")
    self.presentViewController(tbc, animated: true, completion: nil)
  }
  
  
  // MARK: - TEST ACTIONS SB -
  @IBAction func connectSB(sender: UIButton) {
    COMM_HANDLER.sbConnect()
  }
  
  @IBAction func closeSB(sender: UIButton) {
    COMM_HANDLER.sbDisconnect()
  }
  
  @IBAction func atiAction(sender: UIButton) {
    COMM_HANDLER.sbTest()
  }

  @IBAction func sigStrength(sender: UIButton) {
    COMM_HANDLER.sbSignalStrenght()
  }

  // MARK: - TEST ACTIONS WEB REQ -
  @IBAction func connectToWeb(sender: UIButton) {
    COMM_HANDLER.webConnect()
  }
  
  @IBAction func closeToWeb(sender: UIButton) {
    COMM_HANDLER.webDisconnect()
  }
  
  @IBAction func sendToWeb(sender: UIButton) {
    COMM_HANDLER.webSendReq()
  }
  
  
  // MARK: - TEST ACTIONS ANDROID AP -
  @IBAction func connA(sender: UIButton) {
    COMM_HANDLER.apConnect()
  }
  
  @IBAction func dissconnA(sender: UIButton) {
    COMM_HANDLER.apDisconnect()
  }
  
  @IBAction func callA(sender: UIButton) {
    COMM_HANDLER.apCall()
  }
  
  @IBAction func smsA(sender: UIButton) {
    let smsStringMOC = "0791886126090050240E80008861269900002000611082111252002061D7585E86D7D9EAB0BC6C4F8F01E77638CD768DDF6DD09C9E3EBBD3"
    COMM_HANDLER.apSendSMS(smsStringMOC)
  }
}