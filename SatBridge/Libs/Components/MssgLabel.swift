//
//  MssgLabel.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 194//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MssgLabel: UILabel {
  
  let topInset = CGFloat(5.0), bottomInset = CGFloat(5.0), leftInset = CGFloat(8.0), rightInset = CGFloat(8.0)
  
  override func drawTextInRect(rect: CGRect) {
    let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override func intrinsicContentSize() -> CGSize {
    var intrinsicSuperViewContentSize = super.intrinsicContentSize()
    intrinsicSuperViewContentSize.height += topInset + bottomInset
    intrinsicSuperViewContentSize.width += leftInset + rightInset
    return intrinsicSuperViewContentSize
  }
}
