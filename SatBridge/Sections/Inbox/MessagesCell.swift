//
//  MessagesCell.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 84//16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var message: UILabel!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var status: UILabel!
  @IBOutlet weak var avatar: UIImageView!

  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    avatar.layer.cornerRadius = 25.0
    avatar.layer.masksToBounds = true
  }
  
  override func prepareForReuse() {
    avatar.image = UIImage(named: Images.defaultMssgThreadImage)!
  }
}
