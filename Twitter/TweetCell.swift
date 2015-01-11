//
//  TweetCell.swift
//  Twitter
//
//  Created by cm2y on 1/5/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  
  //CUSTOM CELL
  @IBOutlet weak var userNameLabel : UILabel!
  @IBOutlet weak var tweetLabel : UILabel!
  @IBOutlet weak var userLocation : UILabel!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userTwitterHandle: UILabel!
  //need one for date
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      
      
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      super.layoutSubviews()
      self.contentView.layoutIfNeeded()
      self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.width

    }

}

