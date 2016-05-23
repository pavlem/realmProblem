//
//  LeftTriangleView.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 194//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class LeftTriangleView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override func drawRect(rect: CGRect) {
    
    // Get Height and Width
    let layerHeight = self.layer.frame.height
    let layerWidth = self.layer.frame.width
    
    // Create Path
    let bezierPath = UIBezierPath()
    
    // Draw Points
    bezierPath.moveToPoint(CGPointMake(0, layerHeight/2))
    bezierPath.addLineToPoint(CGPointMake(layerWidth, layerHeight))
    bezierPath.addLineToPoint(CGPointMake(layerHeight, 0))
    bezierPath.addLineToPoint(CGPointMake(0, layerHeight/2))
    bezierPath.closePath()
    
    // Apply Color
    Color.receivedMssg.setFill()
    
    bezierPath.fill()
    
    // Mask to Path
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = bezierPath.CGPath
    self.layer.mask = shapeLayer
  }
}
