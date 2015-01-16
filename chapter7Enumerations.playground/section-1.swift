// Playground - noun: a place where people can play

import Cocoa

//OBJ-C
//enum NSStringEncoding {
//    NSASCIIStringEncoding = 1,
//    NSNEXTSTEPStringEncoding = 2,
//    NSJapaneseEUCStringEncoding = 3,
//    NSUTF8StringEncoding = 4
//}
//NSAssert(NSASCIIStringEncoding + “NSNEXTSTEPStringEncoding == NSJapaneseEUCStringEncoding, @"Adds up...");”


enum Encoding {
    case ASCII
    case NEXTSTEP
    case JapaneseEUC
    case UTF8
}

//let myEncoding = Encoding.ASCII + Encoding.UTF8

func toNSStringEncoding(encoding: Encoding) -> NSStringEncoding {
    switch encoding {
    case Encoding.ASCII:
        return NSASCIIStringEncoding
    case Encoding.NEXTSTEP:
        return NSNEXTSTEPStringEncoding
    case Encoding.JapaneseEUC:
        return NSJapaneseEUCStringEncoding
    case Encoding.UTF8:
        return NSUTF8StringEncoding
    }
}

func createEncoding(enc: NSStringEncoding) -> Encoding? {
    switch enc {
    case NSASCIIStringEncoding:
        return Encoding.ASCII
    case NSNEXTSTEPStringEncoding:
        return Encoding.NEXTSTEP
    case NSJapaneseEUCStringEncoding:
        return Encoding.JapaneseEUC
    case NSUTF8StringEncoding:
        return Encoding.UTF8
    default:
        return nil
    }
}


func localizedEncodingName(encoding: Encoding) -> String {
    return String.localizedNameOfStringEncoding(toNSStringEncoding(encoding))
}

localizedEncodingName(Encoding.NEXTSTEP)


//Associated Values

func readFile1(path: String, encoding: Encoding) -> String? {
    var maybeError: NSError? = nil
    let maybeString = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    return maybeString
}

enum ReadFileResult {
    case Success(String)
    case Failure(NSError)
}

let exampleSuccess: ReadFileResult = ReadFileResult.Success("File contents goes here")

func readFile2(path: String, encoding: Encoding) -> ReadFileResult {
    var maybeError: NSError?
    let maybeString: String? = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    
    if let string = maybeString {
        return ReadFileResult.Success(string)
    } else if let error = maybeError {
        return ReadFileResult.Failure(error)
    } else {
        assert(false, "The impossible occurred")
    }
    
}


switch readFile2("/Users/chris/work/npm-debug.log", Encoding.UTF8) {
case let ReadFileResult.Success(contents):
    println("File successfully opened...")
case let ReadFileResult.Failure(error):
    println("Failed to open file. Error code: \(error.code)")
}



//Adding Generics

func writeFile1(contents: String, path: String, encoding: Encoding) -> Bool {
    return contents.writeToFile(path, atomically: false, encoding: toNSStringEncoding(encoding), error: nil)
}


enum WriteFileResult {
    case Success
    case Failure(NSError)
}

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum Result<T> {
    case Success(Box<T>)
    case Failure(NSError)
}

func readFile(path: String, encoding: Encoding) -> Result<String> {
    var maybeError: NSError?
    let maybeString: String? = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    
    if let string = maybeString {
        return Result<String>.Success(Box<String>(string))
    } else if let error = maybeError {
        return Result<String>.Failure(error)
    } else {
        assert(false, "The impossible occurred")
    }
}

func writeFile(contents: String,
    path: String, encoding: Encoding) -> Result<()> {
    var maybeError: NSError?
    var success: Bool? = contents.writeToFile(path,
        atomically: false,
        encoding: toNSStringEncoding(encoding),
        error: &maybeError)
    
        if let err = maybeError {
            return Result<()>.Failure(err)
        }
        
    return Result<()>.Success(Box<()>())
}


//Optionals Revisited

enum Optional<T> {
    case None
    case Some(T)
    //...
}


func map<T, U>(f: T -> U, result: Result<T>) -> Result<U> {
    switch result {
    case let Result.Success(box):
        return Result.Success(Box(f(box.unbox)))
    case let Result.Failure(error):
        return Result.Failure(error)
    }
}

func ??<T>(result: Result<T>, handleError: NSError -> T) -> T {
    switch result {
    case let Result.Success(box):
        return box.unbox
    case let Result.Failure(error):
        return handleError(error)
    }
}
