// Playground - noun: a place where people can play

import Cocoa

func plusIsCommutative(x: Int, y: Int) -> Bool {
    return x + y == y + x
}

//check("Plus should be commutative", plusIsCommutative)

func minusIsCommutative(x: Int, y: Int) -> Bool {
    return x - y == y - x
}
//check("Minus should be commutative", minusIsCommutative)


//check("Additive identity") { (x: Int) in x + 0 == x }


protocol Smaller {
    func smaller() -> Self?
}


extension Int: Smaller {
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}

100.smaller()

extension String: Smaller {
    func smaller() -> String? {
        return self.isEmpty ? nil : dropFirst(self)
    }
}

protocol Arbitrary: Smaller {
    class func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random()) - Int(arc4random())
    }
}

Int.arbitrary()

extension Character: Arbitrary {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(random(from: 65, to: 90)))
    }
    
    func smaller() -> Character? { return nil }
}

func random(#from: Int, #to: Int) -> Int {
    return from + (Int(arc4random()) % (to - from))
}

func tabulate<A>(times: Int, f: Int -> A) -> [A] {
    return Array(0 ..< times).map(f)
}

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = random(from:1, to:40)
        let randomCharacters = tabulate(randomLength) { _ in
            Character.arbitrary()
        }
        return randomCharacters.reduce("", combine: { $0 + String($1)})
    }
}

String.arbitrary()

let numberOfIterations = 5

func check1<A: Arbitrary>(message: String, prop: A -> Bool) -> () {
    for _ in 0 ..< numberOfIterations {
        let value = A.arbitrary()
        if !prop(value) {
            println("\"\(message)\" doesn't hold: \(value)")
            return
        }
    }
    println("\"\(message)\" passed \(numberOfIterations) tests.")
}


extension CGSize: Arbitrary {
    static func arbitrary() -> CGSize {
        return CGSize(width: Int.arbitrary(), height: Int.arbitrary())
    }
}

func area(size: CGSize) -> CGFloat {
    return size.width * size.height
}
check1("Area should be at least 0") { size in area(size) >= 0 }


check1("Every string starts with Hello") { (s: String) in
    s.hasPrefix("Hello")
}







