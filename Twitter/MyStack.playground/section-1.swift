// Playground - noun: a place where people can play

import Cocoa



var alphabetStack: [String] = []

var a = "A"
var b = "B"
var c = "C"



func push (letter: String){
  
  alphabetStack.append(letter)
  
}

func pop () -> String {
  
  var lastIn = alphabetStack.removeLast()
  return lastIn
  
}


func peek () -> String{

  
  return alphabetStack.last!
  
}



//TESTS


//look inside stack
alphabetStack



//push A on
push(a)
//look inside stack
alphabetStack



//push B on
push(b)
//look inside stack
alphabetStack


//push C on
push(c)
//look inside stack
alphabetStack


//pop off first elemenet
var firstOneOut = pop()

//look inside stack
alphabetStack


//see which one is next off
peek()


//pop off next elemenet
var secondOneOut = pop()

//look inside stack
alphabetStack


//pop off last element

var thirdOneOut = pop()


var stackOutput = firstOneOut+secondOneOut+thirdOneOut








