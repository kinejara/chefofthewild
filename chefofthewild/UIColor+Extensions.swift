//
//  UIColor+Extensions.swift
//  chefofthewild
//
//  Created by Jorge Villa on 3/11/17.
//  Copyright © 2017 kinejara. All rights reserved.
//

import Foundation

import UIKit

extension UIImage {
    class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(newSize.width), height: CGFloat(newSize.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
