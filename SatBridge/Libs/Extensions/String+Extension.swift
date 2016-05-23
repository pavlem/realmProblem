//
//  String+Extension.swift
//  ContactsTable
//
//  Created by Pavle Mijatovic on 3/14/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation

extension String {
  var first: String {
    return String(characters.prefix(1))
  }
  var last: String {
    return String(characters.suffix(1))
  }
  var uppercaseFirst: String {
    return first.uppercaseString + String(characters.dropFirst())
  }
  
  func localized() -> String {
    // prefix is nil, as it will use the predefined file prefix
    if let localized = LocalizationHandler.localizedLabelsFromBundleFile()[self] {
      return localized
    }
    return self
  }
}

extension String {
  var length : Int {
    return self.characters.count
  }
  
  func digitsOnly() -> String {
    let stringArray = self.componentsSeparatedByCharactersInSet(
      NSCharacterSet.decimalDigitCharacterSet().invertedSet)
    let newString = stringArray.joinWithSeparator("")
    
    return newString
  }
}