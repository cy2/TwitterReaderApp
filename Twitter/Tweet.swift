//
//  Tweet.swift
//  Twitter
//
//  Created by cm2y on 1/5/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

import Foundation
import UIKit


class Tweet {
  
  
  //**1 add usernames values
  var user : NSDictionary
  var text : String
  var username : String!
  var userlocation: String!
  var imageURL : String!
  var image : UIImage?
  var tweetIDint : Int!
  var userID : String!
  var tweetID : String!
  var favorites : String!
  var retweetID : String?
  var retweetImageURL : String?
  var retweetImage : UIImage?
  
  init( _ jsonDictionary : [String : AnyObject]) {
    self.tweetID = jsonDictionary["id_str"] as String
    self.text = jsonDictionary["text"] as String
    self.user = jsonDictionary["user"] as NSDictionary
    self.userID = user["id_str"] as String
    self.username = user["name"] as String
    self.userlocation = user["location"] as String
    self.imageURL = user["profile_image_url"] as String
    self.favorites = String(user["favourites_count"] as Int)
    
    println("createing tweet id: \(self.tweetID) and loading it's values in tweet object")
    println("tweetID = \(tweetID)")
    println("self.text = \(self.text)")
    println("self.favorites = \(self.favorites)")
    println("self.user = \(self.user)")
    println("self.userID = \(self.userID)")
    println("self.username = \(self.username)")
    println("self.userlocation = \(self.userlocation)")
    println("self.imageURL = \(self.imageURL)")
   
    
  }
  
  //update tweet view controller with network call information
  func updateWithInfo(infoDictionary : [String : AnyObject]) {
    
    let imageURL = user["profile_image_url"] as String
    
    //assign the image value to the cell
    if let tweetimageURL = NSURL(string: imageURL) {
      
      //convert url to data object
      if let imageData = NSData(contentsOfURL: tweetimageURL) {
        
        //create image from data object and update image value
        self.image = UIImage(data: imageData)
        
      }
      
    }
    
  
  }
  
  
  func isARetweet() -> Bool {
    
    var isARetweetStatus = false
    
    let token = NSCharacterSet(charactersInString: " ")
    
    var tweetText: String = self.text
    
    
    var wordsInSentence = tweetText.componentsSeparatedByCharactersInSet(token)
    var handle: String = ""
    
    
    for word in wordsInSentence{
      
      if word.hasPrefix("@"){
        handle = word
        isARetweetStatus = true
        setRetweetHandle()
        break
      }
      
      
    }
  
    
    return isARetweetStatus
  }
  
  
  
  
  func setRetweetHandle(){
    
    let token = NSCharacterSet(charactersInString: " ")
    
    var tweetText: String = self.text
    
    
    var wordsInSentence = tweetText.componentsSeparatedByCharactersInSet(token)
    var handle: String = ""
    
    
    for word in wordsInSentence{
      
      if word.hasPrefix("@"){
        handle = word
        break
      }
      
      
    }
    
    
    //Strip off the : from the end
    
    if(handle.hasSuffix(":")){
      
      let characterCount = countElements(handle)
      let removeLastCharacter = characterCount - 1
      
      handle.substringToIndex(advance(handle.startIndex, removeLastCharacter))
      
    }
    
    
    self.retweetID = handle
    println("Retweet Handle = \(self.retweetID)")
    
    
    
  }
  
  
  
  
  
  

}