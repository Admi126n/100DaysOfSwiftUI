//
//  Checkpoint_7.playground
//  Checkpoint 7 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-7
//
//  Created by Adam on 10/08/2023.
//
//  Goal for this checkpoit:
//
//  Your challenge is this: make a class hierarchy for animals, starting with
//  Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle
//  as subclasses of Dog, and Persian and Lion as subclasses of Cat.
//  But there’s more:
//  - The Animal class should have a legs integer property that tracks how many
//      legs the animal has.
//  - The Dog class should have a speak() method that prints a generic dog barking
//      string, but each of the subclasses should print something slightly different.
//  - The Cat class should have a matching speak() method, again with each subclass
//      printing something different.
//  - The Cat class should have an isTame Boolean property, provided using an initializer.

import Cocoa

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Barking...")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        
        super.init(legs: legs)
    }
    
    func speak() {
        print("Meow...")
    }
}

final class Corgi: Dog {
    override func speak() {
        print("Barking in Corgi lang...")
    }
}

final class Poodle: Dog {
    override func speak() {
        print("Barking in Poodle lang...")
    }
}

final class Persian: Cat {
    override func speak() {
        print("Meow in Persian lang...")
    }
}

final class Lion: Cat {
    override func speak() {
        print("Roar in Lion lang...")
    }
}
