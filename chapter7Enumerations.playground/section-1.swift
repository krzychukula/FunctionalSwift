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

func readFile(path: String, encoding: Encoding) -> ReadFileResult {
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






