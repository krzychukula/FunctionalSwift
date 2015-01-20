// Playground - noun: a place where people can play

import Cocoa

//The Core Data Structures

enum Primitive {
    case Ellipse
    case Rectangle
    case Text(String)
}

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

// A 2-D Vector
struct Vector2D {
    let x: CGFloat
    let y: CGFloat
    var point : CGPoint { return CGPointMake(x, y) }
    
    var size : CGSize { return CGSizeMake(x, y) }
}

enum Diagram {
    case Prim(CGSize, Primitive)
    case Beside(Box<Diagram>, Box<Diagram>)
    case Below(Box<Diagram>, Box<Diagram>)
    case Attributed(Attribure, Box<Diagram>)
    case Align(Vector2D, Box<Diagram>)
}

enum Attribure {
    case FillColor(NSColor)
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .Prim(let size, _):
            return size
        case .Attributed(_, let x):
            return x.unbox.size
        case .Beside(let l, let r):
            let sizeL = l.unbox.size
            let sizeR = r.unbox.size
            return CGSizeMake(sizeL.width + sizeR.width, max(sizeL.height, sizeR.height))
        case .Below(let l, let r):
            let sizeL = l.unbox.size
            let sizeR = r.unbox.size
            return CGSizeMake(max(sizeL.width, sizeR.width), sizeL.height + sizeR.height)
        case .Align(_, let r):
            return r.unbox.size
        }
    }
}

func pointWise(f: (CGFloat, CGFloat) -> CGFloat,
    l: CGPoint, r:CGPoint) -> CGPoint {
        
        return CGPointMake(f(l.x, r.x), f(l.y, r.y))
}

extension CGSize {
    var point : CGPoint {
        return CGPointMake(self.width, self.height)
    }
}

//func /(l: CGSize, r: CGSize) -> CGSize {
//    return pointWise(/, l, r)
//}
//func *(l: CGSize, r: CGSize) -> CGSize {
//    return pointWise(*, l, r)
//}
//func +(l: CGSize, r: CGSize) -> CGSize {
//    return pointWise(+, l, r)
//}
//func -(l: CGSize, r: CGSize) -> CGSize {
//    return pointWise(-, l, r)
//}


//func fit(alignment: Vector2D, inputSize: CGSize, rect: CGRect) -> CGRect {
//    let scaleSize = rect.size / inputSize
//    let scale = min(scaleSize.width, scaleSize.height)
//    
//}


//creating Views and PDFs

class Draw: NSView {
    let diagram: Diagram
    
    init(frame frameRect: NSRect, diagram: Diagram){
        self.diagram = diagram
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        if let context = NSGraphicsContext.currentContext() {
            draw(context.cgContext, self.bounds, diagram)
        }
    }
}

func pdf(diagram: Diagram, width: CGFloat) -> NSData {
    let unitSize = diagram.size
    let height = width * (unitSize.height/unitSize.width)
    let v: Draw = Draw(frame: NSMakeRect(0, 0, width, height), diagram: diagram)
    return v.dataWithPDFInsideRect(v.bounds)
}














