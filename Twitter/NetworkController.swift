//
//  NetworkController.swift
//  Twitter
//
//  Created by cm2y on 1/7/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

import Foundation
import Accounts
import Social

class NetworkController{
  
  //GLOBAL PROPERTIES
  
  //create a property to hold the twitter account
  var twitterAccount : ACAccount?
  
  //create an image queue property
  var imageQueue = NSOperationQueue()

  
  //create an empty init
  init(){
  //blank
  }
  
  //import acounts - using completion handeler callback
  func fetchHomeTimeline( completionHandler: ([Tweet]?,String? ) -> () ){
   
 
  //create an account and fetch twitter data
    
    //create the account
    let accountStore = ACAccountStore()
    
    //create the store
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        
        //if the account contains something
        if !accounts.isEmpty {
          
          //get the first account and update property for future access
          self.twitterAccount = accounts.first as? ACAccount
          
          //create the request url for json file
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          
          //create the fully formed request
          let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          
          
          //sign the request with the account
          twitterRequest.account = self.twitterAccount
          
          //send the request
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            
            
            switch response.statusCode {
              
              
            case 200...299:
              println("Good Server Response")
              
              
              //grab the data from the twitter feed
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
                
                
                //create an empty tweet array
                var mytweets = [Tweet]()

                
                //load the tweets from Json array
                for object in jsonArray {
                  
                  if let jsonDictionary = object as? [String : AnyObject] {
                    
                    
                    let tweet = Tweet(jsonDictionary)
                     
                    mytweets.append(tweet)
                  
                  }
                  
                }
                
                //pass the loaded tweets array back to main thread
                println("Have retrieved \(mytweets.count)tweets")
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(mytweets, nil)
                  
                  //TEST: mimic an empty data set to check alert
                  //completionHandler(nil, "blah")
                })
                
              }
              
              
            case 300...599:
              println("Have retrieved no tweets")
              completionHandler(nil,"Data was bad: Have retrieved no tweets")
              
              
            default:
              println("Server not responding")
              
            }
            //eo switch statement
            
          }
          
        }
      }// eo if granted
      
    }
    
    
  
}// eo fetchHomeTimeline

  
  
//pass in the tweet id and you get back a dictionary and error string
func fetchInfoForTweet(tweetID : String, completionHandler : ([String : AnyObject]?, String?) -> ()) {
   
     println("fetch Info for tweet id: \(tweetID)")
  
    //create the url
     let fetchUrl = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(tweetID)")
  
    //generate the request
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: fetchUrl!, parameters: nil )
  
    //sign it with credentials
    request.account = self.twitterAccount
  
    //send the request
      request.performRequestWithHandler { (data, response, error) -> Void in

        //if the error code is empty
        if error == nil{
          
          println("executed..")
          
          switch response.statusCode{
            
          case 200...299:
            
            //if data came back, pass the dictionary to the func fetchImageForTweet completion handler
            if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [String : AnyObject] {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                
                //call the fetchImageForTweet completion handler
                completionHandler(jsonDictionary, nil)
              })
            }

          default:
            println("Got no data back: case  \(response.statusCode)")
            println("error: \(error)")
            
            
          }
          
          
        }
        
        
    }
    
    
  }//eo fetchInfoForTweet
  
  
  
  //fetch an image on background thread
  
  func fetchImageForTweet(tweet : Tweet, completionHandler: (UIImage?) -> ()) {
    
    //create the image url
    if let imageURL = NSURL(string: tweet.imageURL) {
      
      //add request to the queue
      self.imageQueue.addOperationWithBlock({ () -> Void in
        
        //convert url to data
        if let imageData = NSData(contentsOfURL: imageURL) {
          
          //update tweet object with retrieved imagae
          tweet.image = UIImage(data: imageData)
          
          //call completion handler
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(tweet.image)
          })
          
        }
        
      })
    }
  }// eo fetchImageForTweet
  
  
  
  
  //Grabs the array of tweets for a specific user
  func fetchTimelineForUser(userID: String, completionHandler: ([Tweet]?, String?) -> () ){
    
    //parameters: tell twitter what user this is for , user_id
    let userTimelineRequestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=\(userID)")
    
    //set up the request
    let userTimelineRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: userTimelineRequestURL!, parameters: nil)
    
    //sign the account
    userTimelineRequest.account = self.twitterAccount
    
    //send the request
    userTimelineRequest.performRequestWithHandler {
    (data, response, error ) -> Void in
    
    
    
    ///if data came back, pass the dictionary to the func fetchImageForTweet completion handler
    if error == nil {
      
        switch response.statusCode {
      
          case 200...299:
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
    
              var tweets = [Tweet]()
    
                for object in jsonArray {
    
                      if let jsonDictionary = object as? [String : AnyObject] {
                          let tweet = Tweet(jsonDictionary)
                            tweets.append(tweet)
                      }
              }
    
    
             NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
            })
          
          }
    
    
          default:
            println("Got no data back: case  \(response.statusCode)")
          }
    }
   
    
  }
  
  
  }// eo fetchTimelineForUser
  
  
    //Grabs the array of tweets for a specific user
  func fetchUserImgURLByHandle(retweetHandle: String, completionHandler: ([Tweet]?,String? ) -> () ){
    
      let userTimelineRequestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=\(retweetHandle)")
      
      //set up the request
      let userTimelineRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: userTimelineRequestURL!, parameters: nil)
      
      //sign the account
      userTimelineRequest.account = self.twitterAccount
      
      //send the request
      userTimelineRequest.performRequestWithHandler {
        (data, response, error ) -> Void in
        
        
        
        ///if data came back, pass the dictionary to the func fetchImageForTweet completion handler
        if error == nil {
          
          switch response.statusCode {
            
          case 200...299:
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:nil) as? [AnyObject] {
              
              var tweets = [Tweet]()
              
              for object in jsonArray {
                
                if let jsonDictionary = object as? [String : AnyObject] {
                  
                  
                  println(">>>Grabbing \(jsonDictionary)")
                  
                  //grab and return the retweet url out of the json
                  //break out of loop, only need to grab it once
                  break
                  
                  
                }
              }
              
              
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(tweets, nil)
              })
              
            }
            
            
          default:
            println("Got no data back: case  \(response.statusCode)")
          }
        }else{
          
          println("error processing request")
          
        }
        
        
      }

  }// eo fetchUserImgURLByHandle
  
  
  
  
  
  
}//eo class

 