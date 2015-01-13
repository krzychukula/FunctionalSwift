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

