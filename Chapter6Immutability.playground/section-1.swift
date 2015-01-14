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

class PointClass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}

var classPoint = PointClass(x: 1, y: 2)
var sameClassPoint = classPoint
sameClassPoint.x = 3

