//
//  Checkpoint_5.playground
//  Checkpoint 5 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-5
//
//  Created by Adam on 17/08/2023.
//
//  Goal for this checkpoit:
//
//  Your input is this:
//  let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
//
//  Your job is to:
//  - Filter out any numbers that are even
//  - Sort the array in ascending order
//  - Map them to strings in the format “7 is a lucky number”
//  - Print the resulting array, one item per line

import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter { !$0.isMultiple(of: 2) }
    .sorted()
    .map { "\($0) is a lucky number" }
    .forEach { print($0) }
