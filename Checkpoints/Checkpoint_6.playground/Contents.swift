//
//  Checkpoint_6.playground
//  Checkpoint 6 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-6
//
//  Created by Adam on 19/08/2023.
//
//  Goal for this checkpoit:
//
//  To check your knowledge, here’s a small task for you: create a struct to store
//  information about a car, including its model, number of seats, and current gear,
//  then add a method to change gears up or down. Have a think about variables and
//  access control: what data should be a variable rather than a constant, and what
//  data should be exposed publicly? Should the gear-changing method validate its input somehow?

import Cocoa

enum GearChange {
    case upshift
    case downshift
}

struct Car {
    private(set) var model: String
    private(set) var numberOfSeats: Int
    var currentGear: Int
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        currentGear = 0
    }
    
    mutating func changeGear(_ to: GearChange) {
        switch to {
        case .upshift where currentGear < 6:
            currentGear += 1
        case .downshift where currentGear > 0:
            currentGear -= 1
        default:
            return
        }
    }
}
