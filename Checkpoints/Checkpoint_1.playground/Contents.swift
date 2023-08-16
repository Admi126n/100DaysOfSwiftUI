//
//  Checkpoint_1.playground
//  Checkpoint 1 from 100 Days Of Swift
//  https://www.hackingwithswift.com/quick-start/beginners/checkpoint-1
//
//  Created by Adam on 10/08/2023.
//
//  Goal for this checkpoit:
//
//  Your goal is to write a Swift playground that:
//  - Creates a constant holding any temperature in Celsius.
//  - Converts it to Fahrenheit by multiplying by 9, dividing by 5, then adding 32.
//  - Prints the result for the user, showing both the Celsius and Fahrenheit values.

import Cocoa

let celciusTemp: Double = 36.6
let fahrenhitTemp: Double = celciusTemp * 9 / 5 + 32

print("""
Celcius temperture: \(celciusTemp)°C
Fahrenhit temperature: \(fahrenhitTemp)°F
""")
