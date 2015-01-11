// Playground - noun: a place where people can play

import Cocoa

func incrementArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}

func doubleArray1(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}

func computeIntArray(xs: [Int], f: Int -> Int) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(f(x))
    }
    return result
}

func doubleArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs) { x in x * 2 }
}

//bool type error
//func isEvenArray(xs: [Int]) -> [Bool] {
//    computeIntArray(xs)) { x in x % 2 == 0 }
//}
//
//isEvenArray([1])

func genericComputeArray<U>(xs: [Int], f: Int -> U) -> [U] {
    var result: [U] = []
    for x in xs {
        result.append(f(x))
    }
    return result
}

func map<T, U>(xs: [T], f: T -> U) -> [U] {
    var result: [U] = []
    for x in xs {
        result.append(f(x))
    }
    return result
}

