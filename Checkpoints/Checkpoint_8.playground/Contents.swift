//
//  Checkpoint_8.playground
//  Checkpoint 8 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-8
//
//  Created by Adam on 21/08/2023.
//
//  Goal for this checkpoit:
//
//  Your challenge is this: make a protocol that describes a building,
//  adding various properties and methods, then create two structs, House
//  and Office, that conform to it. Your protocol should require the following:
//  - A property storing how many rooms it has.
//  - A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
//  - A property storing the name of the estate agent responsible for selling the building.
//  - A method for printing the sales summary of the building, describing what it
//      is along with its other properties.

import Cocoa

protocol Building {
    var roomCount: Int { get }
    var cost: Int { get set }
    var agentName: String { get set }
    
    func summary()
}

struct House: Building {
    let roomCount: Int
    var cost: Int
    var agentName: String
    
    func summary() {
        print("This house have \(roomCount) rooms and costs \(cost)")
    }
}

struct Office: Building {
    let roomCount: Int
    var cost: Int
    var agentName: String
    
    func summary() {
        print("This office have \(roomCount) rooms and costs \(cost)")
    }
}
