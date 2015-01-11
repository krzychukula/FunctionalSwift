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

func computeIntArray<T>(xs: [Int], f: Int -> T) -> [T] {
    return map(xs, f)
}

//using Swift map
func doubleArray3(xs: [Int]) -> [Int] {
    return xs.map { x in 2 * x }
}

//FILTER

let exampleFiles = ["README.md", "HelloWorld.swift", "HelloSwift.swift", "FlappyBird.swift"]

func getSwiftFiles(files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}
getSwiftFiles(exampleFiles)


func filter<T>(xs: [T], check: T -> Bool) -> [T] {
    var result: [T] = []
    for x in xs {
        if check(x) {
            result.append(x)
        }
    }
    return result
}

func getSwiftFiles2(files: [String]) -> [String] {
    return filter(files) { file in file.hasSuffix(".swift") }
}

getSwiftFiles2(exampleFiles)

exampleFiles.filter { file in file.hasSuffix(".swift") }


//Reduce

func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    return result
}

let xs = [1,2,3,4]
sum(xs)

func product(xs: [Int]) -> Int {
    var result: Int = 1
    for x in xs {
        result = x * result
    }
    return result
}

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x
    }
    return result
}


func prettyPrintArray(xs: [String]) -> String {
    var result = "Entries in the array xs:\n"
    for x in xs {
        result = result + " " +  x + "\n"
    }
    return result
}

prettyPrintArray(exampleFiles)


func reduce<A, R>(  arr: [A],
                    initialValue: R,
                    combine: (R, A) -> R) -> R {
    var result = initialValue
    for i in arr {
        result = combine(result, i)
    }
    return result
}


func sumUsingReduce(xs: [Int]) -> Int {
    return reduce(xs, 0) { result, x in result + x }
}

sumUsingReduce(xs)

func productUsingReduce(xs: [Int]) -> Int {
    return reduce(xs, 1, *)
}
productUsingReduce(xs)

func concatUsingReduce(xs: [String]) -> String {
    return reduce(xs, "", +)
}
concatUsingReduce(exampleFiles)

reduce(xs, 0, +)
