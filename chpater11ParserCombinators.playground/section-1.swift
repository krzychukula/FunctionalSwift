// Playground - noun: a place where people can play

import Cocoa

//parser Combinators

struct Parser<Token Result> {
    let p: Slice<Token> -> SequenceOf<(Result, Slice<Token>)>
}

func parseA() -> Parser<Character, Character> {
    let a: Character = "a"
    return Parser { x in
        if let (head, tail) = x.decompose {
            if head == a {
                return one((a, tail))
            }
        }
        return none()
    }
}


testParser(parseA(), "abcd")

testParser(parseA(), "test")
//Nothing is working of course because I found in last chapter that searching like creazy for anything that would make code run does not help me actually understand it so why bother?


