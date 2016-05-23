//
//  UIViewController+Extension.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 134//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}