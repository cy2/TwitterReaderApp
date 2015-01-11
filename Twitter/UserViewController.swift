//
//  UserViewController.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 1/9/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource {
  
  var networkController : NetworkController!
  var userID : String!
  var tweets : [Tweet]?
  
  @IBOutlet weak var tableView: UITableView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    self.tableView.estimatedRowHeight = 120
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.tableView.registerNib(UINib(nibName: "TweetNibCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "USER_CELL")
    
    self.networkController.fetchTimelineForUser(self.userID, completionHandler: { (tweets, errorDescription) -> () in
    
      self.tweets = tweets
      self.tableView.reloadData()
    })
    // Do any additional setup after loading the view.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = self.tweets {
      return tweets.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    //figureout what's responsible for displaying cell
    let cell = tableView.dequeueReusableCellWithIdentifier("USER_CELL", forIndexPath: indexPath) as TweetNibCell
    
    //grab the tweet
    let tweet = self.tweets![indexPath.row]
    
    //update the cell label values
    cell.nib_tweetContent.text = tweet.text
    cell.nib_userName.text = tweet.username
    
    
    //if the image isn't empty, update the cell's image value
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        //        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        cell.nib_userImage.image = tweet.image
      })
    } else {
      cell.nib_userImage.image = tweet.image
    }
    
  return cell
    
    
 } //tableView
  
  
}//eo class
