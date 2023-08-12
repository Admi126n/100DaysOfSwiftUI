import Cocoa

var myArray: [String] = ["Cat", "Dog", "Cat", "Cat", "Rabbit"]
var mySet: Set<String> = Set(myArray)

print("""
Items in array: \(myArray.count)
Unique items in array: \(mySet.count)
""")
