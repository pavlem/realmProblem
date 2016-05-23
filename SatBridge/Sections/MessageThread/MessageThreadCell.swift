//
//  MessageThreadCell.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 124//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MessageThreadCell: UITableViewCell {
  
  let cornerRadius = CGFloat(6.0)
  let textBubbleWidthConstraintValue = DeviceProperties.deviceWidth! - 40
  
  @IBOutlet weak var message: UILabel!
  @IBOutlet weak var maxTextBubbleWidthConstraint: NSLayoutConstraint!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    message.layer.cornerRadius = cornerRadius
    message.layer.masksToBounds = true
    maxTextBubbleWidthConstraint.constant = textBubbleWidthConstraintValue
  }
}
