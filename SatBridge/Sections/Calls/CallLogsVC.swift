//
//  CallLogsVC.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 144//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class CallLogsVC: SBTableVC {
  
  // MARK: - Properties -
  @IBOutlet weak var scopeSegmentedControll: UISegmentedControl!
  
  var callLog = CallLog()
  var callLogInfos = [CallLogInfo]()
  var callLogInfosScope = [CallLogInfo]()

  let navBarImageFrame = CGRectMake(0, 0, 40, 40)
  
  let defaultScopeIndex = 0
  let defaultScopeStart = StatusCallLog.all
  
  
  // MARK: - Lifecycle -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    callLogInfos = Array(callLog.callLogInfos).sort{$0.timeStamp > $1.timeStamp}
    callLogInfosScope = callLogInfos
    
    setElements()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    setupDefaulSearchScope()
  }
  
  
  // MARK: - Private -
  private func setupDefaulSearchScope() {
    self.scopeSegmentedControll.selectedSegmentIndex = defaultScopeIndex
    filterContentBasedOnScope(defaultScopeStart)
  }
  
  private func setElements() {
    let image = UIImageView(frame: navBarImageFrame)
    image.contentMode = UIViewContentMode.ScaleAspectFit
    image.layer.cornerRadius = navBarImageFrame.size.width/2
    image.layer.masksToBounds = true
    
    if let imageDataFromDB = callLog.photoThumbImage {
      let imageScaled = resizeImage(UIImage(data:imageDataFromDB)!, newWidth: 40.0)
      image.image = imageScaled
      
    } else {
      let imageScaled = resizeImage(UIImage(named: Images.defaultMssgThreadImage
)!, newWidth: 40.0)
      image.image = imageScaled
    }
    
    self.navigationItem.titleView = image
  }
  
  
  // MARK: - Actions -
  @IBAction func scopeSegmentedControllAction(sender: UISegmentedControl) {
    
    var callScope = String()
    
    switch sender.selectedSegmentIndex {
    case 0:
      callScope = StatusCallLog.all
    case 1:
      callScope = StatusCallLog.dialed
    case 2:
      callScope = StatusCallLog.noAnswer
    case 3:
      callScope = StatusCallLog.received
    case 4:
      callScope = StatusCallLog.missed
    default:
      callScope = ""
    }
    
    filterContentBasedOnScope(callScope)
  }
  
  func filterContentBasedOnScope(selectedScope: String) {
    callLogInfosScope = callLogInfos.filter({ (callLogInfo : CallLogInfo) -> Bool in
      
      let anyScope = callLogInfo.status
      
      if selectedScope == StatusCallLog.all {
        return callLogInfo.status == anyScope
      } else {
        return callLogInfo.status == selectedScope
      }
    })
    
    tableView.reloadData()
  }
}