//
//  HelperFunctions.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit


//MARK: - Images -
func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
  let scale = newWidth / image.size.width
  let newHeight = image.size.height * scale
  UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
  image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
  let newImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()
  
  return newImage
}

//MARK: - Dates -
func daysBetweenDate(startDate: NSDate, endDate: NSDate) -> Int {
  let calendar = NSCalendar.currentCalendar()
  
  let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
  
  return components.day
}

func getApropriateDateStringForDate(startDate: NSDate) -> String {
  
  let currentDate = NSDate()
  let daysDiff = daysBetweenDate(startDate, endDate: currentDate)
  
  var dateText = String()
  
  if daysDiff < 1 {
    dateText = startDate.hourMinSec
  } else if daysDiff > 1 && daysDiff < 2 {
    dateText = "yesterday".localized()
  } else {
    dateText = startDate.shortDate
  }
  
  return dateText
}

func capitalizeFirstLetterInArrayOfStrings(strings: [String]) -> [String] {
  var capitalizedStrings = strings
  for (index, element) in strings.enumerate() {
    capitalizedStrings[index] = element.uppercaseFirst
  }
  return capitalizedStrings
}

func getInitialsFromArrayOfStrings(strings: [String]) -> [String] {
  var initials = strings
  initials = initials.unique
  initials = initials.sort() { $0 < $1 }
  return initials
}

func emoPrint(any: Any){
  print("🍊🍊🍊🍊🍊\(any)🍊🍊🍊🍊🍊")
}


func prepareLoadingIndicatorVC(presentingVC: UIViewController) -> UIViewController {
  presentingVC.providesPresentationContextTransitionStyle = true
  presentingVC.definesPresentationContext = true
  
  let modalVC = UIViewController()
  modalVC.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
  modalVC.view.backgroundColor = UIColor.blackColor()
  modalVC.view.alpha = 0.5
  
  let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  activityView.center = modalVC.view.center
  activityView.startAnimating()
  
  modalVC.view.addSubview(activityView)
  modalVC.view.bringSubviewToFront(activityView)
  
  return modalVC
}

func showLoadingIndicatorView(view: UIView, withFrame frameForLoadingView: CGRect) -> UIView {
  
  let loadingView = UIView(frame: frameForLoadingView)
  loadingView.backgroundColor = UIColor.blackColor()
  loadingView.alpha = 0.5
  
  let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  activityView.center = loadingView.center
  
  var frame = activityView.frame
  frame.origin.y = frameForLoadingView.size.height / 3
  
  activityView.frame = frame
  activityView.startAnimating()
  
  loadingView.addSubview(activityView)
  loadingView.bringSubviewToFront(activityView)
  
  view.addSubview(loadingView)
  view.bringSubviewToFront(loadingView)
  
  return loadingView
}

// MARK: - Network
func showNetworkActivityIndicator(shouldShowActivity activity: Bool) {
  UIApplication.sharedApplication().networkActivityIndicatorVisible = activity
}

func isConnectedToNetwork() -> Bool {
  var zeroAddress = sockaddr_in()
  zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
  zeroAddress.sin_family = sa_family_t(AF_INET)
  let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
    SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
  }
  var flags = SCNetworkReachabilityFlags()
  if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
    return false
  }
  let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
  let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
  return (isReachable && !needsConnection)
}