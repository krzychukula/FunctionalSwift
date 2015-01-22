// Playground - noun: a place where people can play

import Cocoa

//var xs = [];

//for x in xs {
//    //do something with x;
//}

protocol GeneratorType {
    typealias Element
    func next() -> Element?
}

class CountdownGenerator: GeneratorType {
    typealias Element = Int
    
    var element: Element
    
    init<T>(array: [T]){
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return self.element < 0 ? nil : element--
    }
}

let xs = ["A", "B", "C"]

let generator = CountdownGenerator(array: xs)
while let i = generator.next() {
    println("Element \(i) of the array is \(xs[i])")
}

class PowerGenerator: GeneratorType {
    typealias Element = NSDecimalNumber
    
    var power: NSDecimalNumber = NSDecimalNumber(int: 1)
    let two = NSDecimalNumber(int: 2)
    
    func next() -> Element? {
        power = power.decimalNumberByMultiplyingBy(two)
        return power
    }
}

func findPower(predicate: NSDecimalNumber -> Bool) -> NSDecimalNumber {
    let g = PowerGenerator()
    while let x = g.next() {
        if predicate(x) {
            return x
        }
    }
    return 0
}

findPower { $0.integerValue > 1000 }

class FileLinesGenerator: GeneratorType {
    typealias Element = String
    
    var lines: [String]
    
    init(filename: String){
        if let contents = String(contentsOfFile: filename, encoding: NSUTF8StringEncoding, error: nil){
            let newLine = NSCharacterSet.newlineCharacterSet()
            lines = contents.componentsSeparatedByCharactersInSet(newLine)
        }else{
            lines = []
        }
    }
    
    func next() -> Element? {
        if let nextLine = lines.first{
            lines.removeAtIndex(0)
            return nextLine
        }else{
            return nil
        }
    }
}

