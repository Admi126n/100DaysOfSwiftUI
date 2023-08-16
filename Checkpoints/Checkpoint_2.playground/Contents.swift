//
//  Checkpoint_2.playground
//  Checkpoint 2 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-2
//
//  Created by Adam on 12/08/2023.
//
//  Goal for this checkpoit:
//
//  This time the challenge is to create an array of strings, then write some code that prints
//  the number of items in the array and also the number of unique items in the array.

import Cocoa

var myArray: [String] = ["Cat", "Dog", "Cat", "Cat", "Rabbit"]
var mySet: Set<String> = Set(myArray)

print("""
Items in array: \(myArray.count)
Unique items in array: \(mySet.count)
""")
