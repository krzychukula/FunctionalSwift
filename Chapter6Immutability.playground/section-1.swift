// Playground - noun: a place where people can play

import Cocoa

var x: Int = 1
let y: Int = 2

x = 3
//y = 4

struct PointStruct {
    var x: Int
    var y: Int
}

var structPoint = PointStruct(x: 1, y: 2)
var sameStructPoint = structPoint
sameStructPoint.x = 3
structPoint



