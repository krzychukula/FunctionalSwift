// Playground - noun: a place where people can play

import Cocoa

func emptySet<T>() -> Array<T> {
    return []
}

func isEmptySet<T>(set: [T]) -> Bool {
    return set.isEmpty
}

func setContains<T: Equatable>(x: T, set: [T]) -> Bool {
    return contains(set, x)
}

func setInsert<T: Equatable>(x: T, set: [T]) -> [T] {
    return setContains(x, set) ? set : [x] + set
}

enum Tree<T> {
    case Leaf
    case Node(Box<Tree<T>>, Box<T>, Box<Tree<T>>)
}

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}


let leaf: Tree<Int> = Tree.Leaf

let five: Tree<Int> = Tree.Node(Box(leaf), Box(5), Box(leaf))



