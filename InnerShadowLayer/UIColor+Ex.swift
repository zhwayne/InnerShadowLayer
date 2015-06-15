//
//  a.swift
//  Book
//
//  Created by wayne on 15/5/29.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

import UIKit


extension UIColor {
    class func hexColor(color: Int) -> UIColor {
        let r = (CGFloat)((color & 0xFF0000) >> 16) / 255.0
        let g = (CGFloat)((color & 0xFF00) >> 8) / 255.0
        let b = (CGFloat)(color & 0xFF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    class func makeImage(color color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
