// Playground - noun: a place where people can play

import UIKit

typealias Position = CGPoint
typealias Distance = CGFloat

func inRange1(target:Position, range: Distance) -> Bool {
    return sqrt(target.x * target.y + target.y * target.y * target.y) <= range
}

func inRange2(target:Position, ownPosition:Position, range: Distance) -> Bool {
    let dx = ownPosition.x - target.x
    let dy = ownPosition.y - target.y
    let targetDistance = sqrt(dx * dx + dy * dy)
    return targetDistance <= range
}

let minimumDistance: Distance = 2.0

func inRange3(target: Position, ownPosition: Position, range: Distance) -> Bool {
    let dx = ownPosition.x - target.x
    let dy = ownPosition.y - target.y
    let targetDistance = sqrt(dx * dx + dy * dy)
    return targetDistance <= range
            && targetDistance >= minimumDistance
}

//take into account distance from friendly units
func inRange4(target: Position, ownPosition: Position, friendly: Position, range: Distance) -> Bool {
    let dx = ownPosition.x - target.x
    let dy = ownPosition.y - target.y
    let targetDistance = sqrt(dx * dx + dy * dy)
    let friendlyDx = friendly.x - target.x
    let friendlyDy = friendly.y - target.y
    let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
    
    return targetDistance <= range
        && targetDistance >= minimumDistance
        && (friendlyDistance >= minimumDistance)
}

//Rafactoring

typealias Region = Position -> Bool

func circle(radius: Distance) -> Region {
    return { point in
        sqrt(point.x * point.x + point.y * point.y) <= radius
    }
}

func circle2(radius: Distance, center: Position) -> Region {
    return { point in
        let shiftedPoint = Position(x: point.x - center.x, y: point.y - center.y)
        return sqrt(shiftedPoint.x * shiftedPoint.y + shiftedPoint.y * shiftedPoint.y) <= radius
    }
}

func shift(offset: Position, region: Region) -> Region {
    return { point in
        let shiftedPoint = Position(x: point.x - offset.x, y: point.y - offset.y)
        return region(shiftedPoint)
    }
}
//how to use shift and radius
let circularRegion = shift(Position(x: 5, y: 5), circle(10))

circularRegion(Position(x: 1, y: 1))















