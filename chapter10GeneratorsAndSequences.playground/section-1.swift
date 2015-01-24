// Playground - noun: a place where people can play

import Cocoa

//var xs = [];

//for x in xs {
//    //do something with x;
//}

//protocol GeneratorType {
//    typealias Element
//    func next() -> Element?
//}

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

func find<G: GeneratorType>(var generator: G, predicate: G.Element -> Bool) -> G.Element? {
    while let x = generator.next() {
        if predicate(x) {
            return x
        }
    }
    return nil
}

class LimitGenerator<G: GeneratorType>:GeneratorType {
    typealias Element = G.Element
    var limit = 0
    var generator: G
    
    init(limit: Int, generator: G){
        self.limit = limit
        self.generator = generator
    }
    
    func next() -> Element? {
        if limit >= 0 {
            limit--
            return generator.next()
        }else{
            return nil
        }
    }
}

//GeneratorOf

func cuntDown(start: Int) -> GeneratorOf<Int> {
    var i = start
    return GeneratorOf { return i < 0 ? nil : i-- }
}


func +<A>(var first: GeneratorOf<A>, var second: GeneratorOf<A>) -> GeneratorOf<A> {
    return GeneratorOf {
        if let x = first.next() {
            return x
        }else if let x = second.next() {
            return x
        }
        return nil
    }
}

//Sequences

//func map<A, B>(s: SequenceOf<A>, f: A -> B) -> SequenceOf<B> {
//    return SequenceOf { map(s.generate(), f) }
//}


//protocol SequenceType {
//    typealias Generator: GeneratorType
//    func generate() -> Generator
//}


struct ReverseSequence<T>: SequenceType {
    var array: [T]
    
    init(array: [T]){
        self.array = array
    }
    
    typealias Generator = CountdownGenerator
    
    func generate() -> Generator {
        return Generator(array: array)
    }
}

let reverseSequence = ReverseSequence(array: xs)
let reverseGenerator = reverseSequence.generate()

while let i = reverseGenerator.next() {
    println("Index \(i) is '\(xs[i])")
}

for i in ReverseSequence(array: xs) {
    println("Index \(i) is '\(xs[i])")
}

//map, filter...

//func filter<S: SequenceType>(source: S,
//    includeElement: S.Generator.Element -> Bool)
//    -> [S.Generator.Element]

//func map<S: SequenceType, T>(source: S,
//    transform: S.Generator.Element -> T)
//    -> [T]

let reverseElements = map(ReverseSequence(array: xs)) { i in xs[i]}

for x in reverseElements {
    println("Element is \(x)")
}



//func lazy<S: SequenceType>(s: S) -> LazySequence<S>


//Traversing a Binary Tree


class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}


enum Tree<T> {
    case Leaf
    case Node(Box<Tree<T>>, T, Box<Tree<T>>)
}

//struct GeneratorOfOne<T>: GeneratorType, SequenceType {
//    
//    init(_ element: T?)
//    // ...
//}

let three: [Int] = Array(GeneratorOfOne(3))
let empty: [Int] = Array(GeneratorOfOne(nil))

func one<X>(x: X?) -> GeneratorOf<X> {
    return GeneratorOf(GeneratorOfOne(x))
}

func inOrder<T>(tree: Tree<T>) -> GeneratorOf<T> {
    switch tree {
    case Tree.Leaf:
        return GeneratorOf {return nil}
    case let Tree.Node(left, x, right):
        return inOrder(left.unbox) + one(x) + inOrder(right.unbox)
    }
}

//Better Shrinking QuickCheck

//protocol Smaller {
//    func smaller() -> Self?
//}
//
//extension Array: Smaller {
//    func smaller() -> [T]? {
//        if (!self.isEmpty) {
//            return Array(dropFirst(self))
//        }
//        return nil
//    }
//}

protocol Smaller {
    func smaller() -> GeneratorOf<Self>
}

//from additional code
extension Int: Smaller {
    func smaller() -> GeneratorOf<Int> {
        let result: Int? = self < 0 ? nil : self.predecessor()
        return one(result)
    }
}

func removeElement<T>(var array: [T]) -> GeneratorOf<[T]> {
    var i = 0
    return GeneratorOf {
        if i < array.count {
            var result = array
            result.removeAtIndex(i)
            i++
            return result
        }
        return nil
    }
}
removeElement([1,2,3])
Array(removeElement([1,2,3]))




