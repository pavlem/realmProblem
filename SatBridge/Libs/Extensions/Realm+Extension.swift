//
//  Realm+Extension.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 114//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


extension Results {
  
  func uniqueValueForObject<U : Equatable>(objectKey: String, paramKey: String, type: U.Type)->[U]{
    
    var uniqueValues : [U] = [U]()
    
    for obj in self {
      
      if let o = obj.valueForKeyPath(objectKey) {
        
        if let v = o.valueForKeyPath(paramKey){
          
          if(!uniqueValues.contains(v as! U)){
            uniqueValues.append(v as! U)
          }
          
        }
      }
      
    }
    return uniqueValues
  }
  
  func uniqueValue<U : Equatable>(paramKey: String, type: U.Type)->[U]{
    
    var uniqueValues : [U] = [U]()
    
    for obj in self {
      
      if let val = obj.valueForKeyPath(paramKey) {
        
        if (!uniqueValues.contains(val as! U)) {
          uniqueValues.append(val as! U)
        }
        
      }
      
    }
    return uniqueValues
  }
  
  func uniqueObject(paramKey: String)->[Object]{
    
    var uniqueObjects : [Object] = [Object]()
    
    for obj in self {
      
      if let val = obj.valueForKeyPath(paramKey) {
        let uniqueObj : Object = val as! Object
        if !uniqueObjects.contains(uniqueObj) {
          uniqueObjects.append(uniqueObj)
        }
      }
      
    }
    return uniqueObjects
  }
}