// Playground - noun: a place where people can play

import UIKit

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