//
//  ViewController.swift
//  Twitter
//
//  Created by cm2y on 1/5/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//


import UIKit
import Accounts
import Social

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
  @IBOutlet weak var tableView: UITableView!
  
  //**6 create an instance of the Tweets class
  var importedtweets = [Tweet]()
  
  //create an instance of the network controller
  var networkController = NetworkController()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //call the network controller
    self.networkController.fetchHomeTimeline { (importedtweets, errorString) -> () in
      
      //if it works
      if errorString == nil{
        
        self.importedtweets=importedtweets!
        self.tableView.reloadData()
        
      }else{
        
        var alert = UIAlertView(title: "Importing Tweets Failed", message: "Please try again", delegate: self,
          cancelButtonTitle: "Cancel")
        
        
        alert.show()
      }
      self.tableView.reloadData()
      
    }
    
    
    self.tableView.estimatedRowHeight = 144
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.importedtweets.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    //**12 create the cell row
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    
    println("cell created")
    let tweet = self.importedtweets[indexPath.row]
    
    //**13 assign the label values from Tweet instance
    cell.tweetLabel.text = tweet.text
    cell.userNameLabel.text = tweet.username
    cell.userLocation.text = tweet.userlocation
   
    
    //Create an image object
   
    //assign the image value to the cell
    if let tweetimageURL = NSURL(string: tweet.imageURL) {
     
      //convert url to data object
      if let imageData = NSData(contentsOfURL: tweetimageURL) {
        
        //create image from data object
        cell.userImage.image = UIImage(data: imageData)
        
      }
      
    }
    return cell
  }//eo tableView
  
  
  
  
  
  //method to call any time you click on a cell
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    //create the tweets view controller
    let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetViewController
    
    // why?
    tweetVC.networkController = self.networkController
    
    //give it a copy of the tweet at the selected row
    tweetVC.tweet = self.importedtweets[indexPath.row]
    
    //send redirect
    self.navigationController?.pushViewController(tweetVC, animated: true)
    
    
    
    
  }
  
}