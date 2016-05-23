//
//  TechLogCell.swift
//  SatBridge
//
//  Created by Pavle Mijatovic on 3/3/16.
//  Copyright © 2016 Carnegie Technologies. All rights reserved.
//

import UIKit

class TechLogCell: UITableViewCell {
  
  @IBOutlet weak var infoMain: UILabel!
  @IBOutlet weak var infoHelp: UILabel!
  @IBOutlet weak var date: UILabel!

  
  var techLog: TechLogMOC! {
    didSet {
      infoMain.text = techLog.infoMain
      infoHelp.text = techLog.infoHelp
      date.text = techLog.date
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
