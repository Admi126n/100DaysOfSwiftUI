//
//  Checkpoint_4.playground
//  Checkpoint 4 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-4
//
//  Created by Adam on 16/08/2023.
//
//  Goal for this checkpoit:
//
//  The challenge is this: write a function that accepts an integer from 1 through 10,000,
//  and returns the integer square root of that number. That sounds easy, but there are some catches:
//  - You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
//  - If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
//  - You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
//  - If you can’t find the square root, throw a “no root” error.

import Cocoa

enum SqrtErrors: Error {
    case outOfBounds
    case noRoot
}

func findSquareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw SqrtErrors.outOfBounds
    }
    
    // because we accept only integers in range 1 through 10_000 possible square roots are in range 1 through 100
    for squareRoot in 1...100 {
        if squareRoot * squareRoot == number {
            return squareRoot
        }
    }
    
    // if no square root returned just throw an error
    throw SqrtErrors.noRoot
}

do {
    let squareRoot = try findSquareRoot(of: 1024)
    print(squareRoot)
} catch {
    print("There was an error: \(error)")
}
