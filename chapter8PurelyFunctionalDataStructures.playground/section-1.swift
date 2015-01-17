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








