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

