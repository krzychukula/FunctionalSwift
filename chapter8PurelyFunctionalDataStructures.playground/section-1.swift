// Playground - noun: a place where people can play

import Cocoa

//func emptySet<T>() -> Array<T> {
//    return []
//}
//
//func isEmptySet<T>(set: [T]) -> Bool {
//    return set.isEmpty
//}
//
//func setContains<T: Equatable>(x: T, set: [T]) -> Bool {
//    return contains(set, x)
//}
//
//func setInsert<T: Equatable>(x: T, set: [T]) -> [T] {
//    return setContains(x, set) ? set : [x] + set
//}

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


func single<T>(x: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(x), Box(Tree.Leaf))
}


func count<T>(tree: Tree<T>) -> Int {
    switch tree {
    case let Tree.Leaf:
        return 0
    case let Tree.Node(left, x, right):
        return 1 + count(left.unbox) + count(right.unbox)
    }
}

func elements<T>(tree: Tree<T>) -> [T] {
    switch tree {
    case let Tree.Leaf:
        return []
    case let Tree.Node(left, x, right):
        return elements(left.unbox) + [x.unbox] + elements(right.unbox)
    }
}

func emptySet<T>() -> Tree<T> {
    return Tree.Leaf
}

func isEmptySet<T>(tree: Tree<T>) -> Bool {
    switch tree {
    case let Tree.Leaf:
        return true
    case let Tree.Node(_, _, _):
        return false
    }
}

//binary search trees

func isBST<T: Comparable>(tree: Tree<T>) -> Bool {
    switch tree {
    case Tree.Leaf:
        return true
    case let Tree.Node(left, x, right):
        let leftElements = elements(left.unbox)
        let rightElements = elements(right.unbox)
        
        return all(leftElements) { y in y < x.unbox }
            && all(rightElements) { y in y > x.unbox }
            && isBST(left.unbox)
            && isBST(right.unbox)
        
    }
}


func all<T> (xs: [T], predicate: T -> Bool) -> Bool {
    for x in xs {
        if !predicate(x) {
            return false
        }
    }
    return true
}

func setContains<T: Comparable>(x: T, tree: Tree<T>) -> Bool {
    switch tree {
    case Tree.Leaf:
        return false
    case let Tree.Node(left, y, right) where x == y.unbox:
        return true
    case let Tree.Node(left, y, right) where x < y.unbox:
        return setContains(x, left.unbox)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return setContains(x, right.unbox)
    default:
        assert(false, "The impossible occurred")
    }
}
