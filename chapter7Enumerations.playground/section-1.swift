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