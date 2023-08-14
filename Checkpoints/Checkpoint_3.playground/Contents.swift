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
