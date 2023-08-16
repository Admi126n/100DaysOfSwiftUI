//
//  Checkpoint_3.playground
//  Checkpoint 3 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-3
//
//  Created by Adam on 14/08/2023.
//
//  Goal for this checkpoit:
//
//  The problem is called fizz buzz, and has been used in job interviews, university entrance
//  tests, and more for as long as I can remember. Your goal is to loop from 1 through 100,
//  and for each number:
//  - If it’s a multiple of 3, print “Fizz”
//  - If it’s a multiple of 5, print “Buzz”
//  - If it’s a multiple of 3 and 5, print “FizzBuzz”
//  - Otherwise, just print the number.

import Cocoa

var output = ""

for i in 1...100 {
    if i.isMultiple(of: 3) {
        output += "Fizz"
    }
    if i.isMultiple(of: 5) {
        output += "Buzz"
    }
    
    print(output.isEmpty ? i : output)
    output = ""
}
