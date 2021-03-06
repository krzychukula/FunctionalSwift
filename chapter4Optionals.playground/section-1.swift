// Playground - noun: a place where people can play

import Cocoa

let cities = ["Paris": 2243, "Madrid":3216,"Amsterdam":881, "Berlin":3397]

let madridPopulation: Int? = cities["Madrid"]

if madridPopulation != nil {
    println("The population of Madrid is " +
    "\(madridPopulation! * 1000)")
}else{
    println("Unknown city: Madrid")
}

if let madridPopulation = cities["Madrid"] {
    println("The population of Madrid is " +
        "\(madridPopulation * 1000)")
}else{
    println("Unknown city: Madrid")
}

//infix operator ??
func ??<T>(optional: T?, defaultValue: T) -> T {
    if let x = optional {
        return x
    }else {
        return defaultValue
    }
}

func ??<T>(optional: T?, defaultValue: () -> T) -> T {
    if let x = optional {
        return x
    }else {
        return defaultValue()
    }
}

madridPopulation ?? { 12 }

//infix operator ?? { associativity right precedence 110 }
func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    if let x = optional {
        return x
    }else {
        return defaultValue()
    }
}

struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name: String
    let address: Address?
}

struct Address {
    let streetName: String
    let city: String
    let state: String?
}

//order.person!.address!.state!
let order = Order(orderNumber: 1, person: Person(name: "Func Funky", address: Address(streetName: "mud", city: "muddy", state: "missing")))

if let myState = order.person?.address?.state? {
    println("This order will be shipped to \(myState)")
}else {
    println("Unknown person, address, or state")
}



//MARK: Maps and More
func incrementOptional(optional: Int?) -> Int? {
    if let x = optional {
        return x + 1
    }else{
        return nil
    }
}

func map<T, U>(optional: T?, f: T -> U) -> U? {
    if let x = optional {
        return f(x)
    }else{
        return nil
    }
}

func incrementOptional2(optional: Int?) -> Int? {
    return optional.map { x in x + 1 }
}

let x: Int? = 3
let y: Int? = nil
//let z: Int? = x + y

func addOptionals(optionalX: Int?, optionalY: Int?) -> Int? {
    if let x = optionalX {
        if let y = optionalY {
            return x + y
        }
    }
    return nil
}


let capitals = ["France": "Paris", "Spain": "Madrid", "The Netherlands": "Amsterdam", "Belgium": "Brussels"]

func populationOfCapital(country: String) -> Int? {
    if let capital = capitals[country] {
        if let population = cities[capital] {
            return population * 1000
        }
    }
    return nil
}

populationOfCapital("France")
populationOfCapital("Poland")


infix operator >>= {}
func >>=<U, T>(optional: T?, f: T -> U?) -> U? {
    if let x = optional {
        return f(x)
    }else {
        return nil
    }
}

func addOptional2(optionalX: Int?, optionalY: Int?) -> Int? {
    return optionalX >>= { x in
        optionalY >>= { y in
            x + y
        }
    }
}

func populationOfCapital2(country: String) -> Int? {
    return capitals[country] >>= { capital in
        cities[capital] >>= { population in
            return population * 1000
        }
    }
}


