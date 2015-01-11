
/*

// I need to tokenise out the retweeted handel from the string


*/
import Cocoa


let token = NSCharacterSet(charactersInString: " ")

var tweetText: String = "RT @SlideShareToday: 'The Future of a Brand by Joanna Lord - SIC2014' by @seattleinteract is featured on our homepage. http://t.co/sbQZkBnJ…"


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








