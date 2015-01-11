//
//  TweetNibCell.swift
//  Twitter
//
//  Created by cm2y on 1/9/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {
  
  
  @IBOutlet weak var nib_userImage: UIImageView!
  
  @IBOutlet weak var nib_userName: UILabel!
  
  
  @IBOutlet weak var nib_tweetContent: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    
    
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.nib_userName.preferredMaxLayoutWidth = self.nib_userName.frame.width
    
  }
  
}


