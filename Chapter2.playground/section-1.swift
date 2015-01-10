// Playground - noun: a place where people can play

import Cocoa

typealias Filter = CIImage -> CIImage

typealias Parameters = Dictionary<String, AnyObject>

extension CIFilter {
    convenience init(name: String, parameters: Parameters) {
        self.init(name: name)
        setDefaults()
        for(key, value: AnyObject) in parameters {
            setValue(value, forKey: key)
        }
    }
    
    var outputImage: CIImage {
        return self.valueForKey(kCIOutputImageKey) as CIImage
    }
}

func blur(radius: Double) -> Filter {
    return { image in
        let parameters: Parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey: image
        ]
        let filter = CIFilter(name: "CIGaussianBlur", parameters:parameters)
        
        return filter.outputImage
    }
}

func colorGenerator(color: NSColor) -> Filter {
    return { _ in
        let parameters: Parameters = [kCIInputColorKey: color]
        let filter = CIFilter(name: "CIConstantColorGenerator", parameters: parameters)
        return filter.outputImage
    }
}

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters: Parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        let filter = CIFilter(name: "CISourceOverCompositing", parameters: parameters)
        let cropRect = image.extent()
        return filter.outputImage.imageByCroppingToRect(cropRect)
    }
}


func colorOverlay(color: NSColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
        return compositeSourceOver(overlay)(image)
    }
}

var url = NSURL(string: "http://tinyurl.com/m74sldb")

let blurRadius = 5.0
let overlayColor = NSColor.redColor().colorWithAlphaComponent(0.2)
let image = CIImage(contentsOfURL: url)

if image != nil {

    let blurredImage = blur(blurRadius)(image)
    let overlaidImage = colorOverlay(overlayColor)(blurredImage)

}

func composeFilters(filter1: Filter, filter2: Filter) -> Filter {
    return { img in filter2(filter1(img)) }
}

let myFilter1 = composeFilters(blur(blurRadius), colorOverlay(overlayColor))

if image != nil {
    let result1 = myFilter1(image)
}

infix operator >>> { associativity left }

func >>> (filter1: Filter, filter2: Filter) -> Filter {
    return { img in filter2(filter1(img)) }
}

let myFilter2 = blur(blurRadius) >>> colorOverlay(overlayColor)

if image != nil {
    let result2 = myFilter2(image)
}

func add3(x: Int)(y: Int) -> Int {
    return x + y
}

add3(1)(y: 2)







