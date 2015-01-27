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





