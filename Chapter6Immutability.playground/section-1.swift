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


func setStructToOrigin(var point: PointStruct) -> PointStruct {
    //struct is copied
    point.x = 0
    point.y = 0
    return point
}

var structOrigin: PointStruct = setStructToOrigin(structPoint)
structPoint


func setClassToOrigin(point: PointClass) -> PointClass {
    //changes passed object
    point.x = 0
    point.y = 0
    return point
}

var classOrigin = setClassToOrigin(classPoint)


let immutablePoint = PointStruct(x: 0, y: 0)

//rejected
//immutablePoint = PointStruct(x: 1, y: 1)
//immutablePoint.x = 3

var mutablePoint = PointStruct(x: 1, y: 1)
mutablePoint.x = 3

struct ImmutablePointStruct {
    let x: Int
    let y: Int
}

var immutablePoint2 = ImmutablePointStruct(x: 1, y: 1)
//rejected
//immutablePoint2.x = 3

immutablePoint2 = ImmutablePointStruct(x: 2, y: 2)










