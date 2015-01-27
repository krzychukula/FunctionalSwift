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

func parseCharacter(character: Character) -> Parser<Character, Character> {
    return Parser { x in
        if let (head, tail) = x.decompose {
            if head == character {
                return one((character, tail))
            }
        }
        return none()
    }
}

testParser(parseCharacter("t"), "test")

func satisfy<Token>(condition: Token -> Bool) -> Parser<Token, Token> {
    
    return Parser { x in
        if let (head, tail) = x.decompose {
            if condition(head) {
                return one((head, tail))
            }
        }
        return none()
    }
}
func token<Token: Equatable>(t: Token) -> Parser<Token, Token> {
        return satisfy { $0 == t }
}


//Choice

infix operator <|> { associativity right precedence 130 }
func <|> <Token, A>(l: Parser<Token, A>,
    r: Parser<Token, A>) -> Parser<Token, A> {
        
        return Parser { input in
            l.p(input) + r.p(input)
        }
}


let a: Character = "a"
let b: Character = "b"

testParser(token(a) <|> token(b), "bcd")



//Sequence


func sequence<Token, A, B>(l: Parser<Token, A>,
    r: Parser<Token, B>) -> Parser<Token, (A, B)> {
        
        return Parser { input in
            let leftResults = l.p(input)
            return flatMap(leftResults) { a, leftRest in
                let rightResults = r.p(leftRest)
                return map(rightResults, { b, rightRest in
                    ((a, b), rightRest)
                })
            }
        }
}


let x: Character = "x"
let y: Character = "y"
let p: Parser<Character, (Character, Character)> = sequence(token(x), token(y))
testParser(p, "xyz")


//Refining Sequence

func integerParser<Token>() -> Parser<Token, Character -> Int> {
    return Parser { input in
        return one(({x in String(x).toInt()! }, input))
    }
}


func combinator<Token, A, B>(l: Parser<Token, A -> B>, r: Parser<Token, A>) -> Parser<Token, B> {
    
    return Parser { input in
        let leftResults = l.p(input)
        return flatMap(leftResults) { f, leftRemainder in
            let rightResults = r.p(leftRemainder)
            return map(rightResults) { x, rightRemainder in
                (f(x), rightRemainder)
            }
        }
    }
}


let three: Character = "3"

testParser(combinator(integerParser(), token(three)), "3")


func pure<Token, A>(value: A) -> Parser<Token, A> {
    return Parser { one((value, $0)) }
}

func toInteger(c: Character) -> Int {
    return String(c).toInt()!
}
testParser(combinator(pure(toInteger), token(three)), "3")

func toInteger2(c1: Character)(c2: Character) -> Int {
    let combined = String(c1) + String(c2)
    return combined.toInt()!
}

testParser(combinator(combinator(pure(toInteger2), token(three)), token(three)), "33")


infix operator <*> { associativity left precedence 150 }
func <*><Token, A, B>(l: Parser<Token, A -> B>, r: Parser<Token, A>) -> Parser<Token, B> {
    
    return Parser { input in
        let leftResults = l.p(input)
        return flatMap(leftResults) { f, leftRemainder in
            let rightResults = r.p(leftRemainder)
            return map(rightResults) { x, y in
                (f(x), y)
            }
        }
    }
}


testParser(pure(toInteger2) <*> token(three) <*> token(three), "33")





















