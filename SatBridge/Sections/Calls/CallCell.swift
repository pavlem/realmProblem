//
//  CallCell.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/17/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class CallCell: UITableViewCell {
  
  @IBOutlet weak var contactImage: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var status: UILabel!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var totalCalls: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contactImage.layer.cornerRadius = 25.0
    contactImage.layer.masksToBounds = true
  }
  
  override func prepareForReuse() {
    contactImage.image = UIImage(named: Images.defaultMssgThreadImage)!
  }
}


