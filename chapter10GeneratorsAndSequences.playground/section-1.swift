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