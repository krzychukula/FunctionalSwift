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