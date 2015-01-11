//
//  TweetViewController.swift
//  Twitter
//
//  Created by cm2y on 1/8/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

import Foundation


import UIKit

class TweetViewController: UIViewController {
  
  var tweet : Tweet!
  
  @IBOutlet weak var tweetUserImage: UIImageView!
  
  @IBOutlet weak var tweetUserName: UILabel!
  
  @IBOutlet weak var tweetContent: UILabel!
  
  @IBOutlet weak var tweetFavorites: UILabel!
  
  @IBOutlet weak var buttonUserTimeLine: UIButton!
  
  var networkController : NetworkController!
  
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    

    //make a call to fetch more tweet info with the id
    self.networkController.fetchInfoForTweet(tweet.tweetID, completionHandler: { (infoDictionary, errorDescription) -> () in
      
      println(infoDictionary)
      
      if errorDescription == nil {
        self.tweet.updateWithInfo(infoDictionary!)
        
        //self.tweetUserImage.image = self.tweet.image
        self.buttonUserTimeLine.setBackgroundImage(self.tweet.image, forState: UIControlState.Normal)
      
      }
      
      //self.tweetUserImage.image = tweet.image
      self.tweetUserName.text = self.tweet.username
      self.tweetContent.text = self.tweet.text
      self.tweetFavorites.text = " \(self.tweet.favorites) Favorites"
      
      
    })
    
  }//eo view did load


  @IBAction func onClick(sender: AnyObject) {
    
    let userVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_VC") as UserViewController
    userVC.networkController = self.networkController
    userVC.userID = self.tweet.userID
    self.navigationController?.pushViewController(userVC, animated: true)
    
    
  }
  


}


