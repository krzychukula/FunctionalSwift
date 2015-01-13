// Playground - noun: a place where people can play

import Cocoa

func plusIsCommutative(x: Int, y: Int) -> Bool {
    return x + y == y + x
}

check("Plus should be commutative", plusIsCommutative)

func minusIsCommutative(x: Int, y: Int) -> Bool {
    return x - y == y - x
}
check("Minus should be commutative", minusIsCommutative)

func check(message: String, f: (Int, Int) -> Bool) {
    
}
func check(message: String, f: (Int) -> Bool) {
    
}

check("Additive identity") { (x: Int) in x + 0 == x }

protocol Arbitrary {
    class func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
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



