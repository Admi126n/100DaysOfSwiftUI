//
//  Checkpoint_9.playground
//  Checkpoint 9 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-9
//
//  Created by Adam on 22/08/2023.
//
//  Goal for this checkpoit:
//
//  Your challenge is this: write a function that accepts an optional array
//  of integers, and returns one randomly. If the array is missing or empty,
//  return a random number in the range 1 through 100.
//  If that sounds easy, it’s because I haven’t explained the catch yet: I want
//  you to write your function in a single line of code. No, that doesn’t mean
//  you should just write lots of code then remove all the line breaks – you
//  should be able to write this whole thing in one line of code.

import Cocoa

func getRandomElement(from array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}
