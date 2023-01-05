//
//  InnerShadowLayer.swift
//  InnerShadowLayer
//
//  Created by wayne on 15/6/13.
//  Copyright © 2015年 wayne. All rights reserved.
//

import UIKit

class InnerShadowLayer: CALayer {
    
    var innerShadowColor: CGColor = UIColor.black.cgColor {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowOffset: CGSize = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowRadius: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    var innerShadowOpacity: Float = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        masksToBounds      = true
        shouldRasterize    = true
        contentsScale      = UIScreen.main.scale
        rasterizationScale = UIScreen.main.scale
        isOpaque = false
        setNeedsDisplay()
    }
    
    override func draw(in ctx: CGContext) {
        // 设置 Context 属性
        // 允许抗锯齿
        ctx.setAllowsAntialiasing(true);
        // 允许平滑
        ctx.setShouldAntialias(true);
        // 设置插值质量
        ctx.interpolationQuality = .high
        
        // 以下为核心代码
        
        // 创建 color space
        let colorspace = CGColorSpaceCreateDeviceRGB();
        
        var rect   = bounds
        var radius = cornerRadius
        
        // 去除边框的大小
        if self.borderWidth != 0 {
            rect   = CGRectInset(rect, borderWidth, borderWidth);
            radius -= self.borderWidth
            radius = max(radius, 0)
        }
        
        // 创建 inner shadow 的镂空路径
        let someInnerPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: radius).reversing().cgPath
        ctx.addPath(someInnerPath)
        ctx.clip()
        
        // 创建阴影填充区域，并镂空中心
        let shadowPath = CGMutablePath()
        let shadowRect = CGRectInset(rect, -rect.size.width, -rect.size.width)
        shadowPath.addRect(shadowRect)
        shadowPath.addPath(someInnerPath)
        shadowPath.closeSubpath()
        
        // 获取填充颜色信息
        let oldComponents: [CGFloat] = innerShadowColor.components ?? [0, 0, 0, 0]
        var newComponents: [CGFloat] = [0, 0, 0, 0]
        let numberOfComponents: Int = oldComponents.count;
        switch numberOfComponents {
        case 2:
            // 灰度
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[0]
            newComponents[2] = oldComponents[0]
            newComponents[3] = oldComponents[1] * CGFloat(innerShadowOpacity)
        case 4:
            // RGBA
            newComponents[0] = oldComponents[0]
            newComponents[1] = oldComponents[1]
            newComponents[2] = oldComponents[2]
            newComponents[3] = oldComponents[3] * CGFloat(innerShadowOpacity)
        default: break
        }
        
        // 根据颜色信息创建填充色
        guard let innerShadowColorWithMultipliedAlpha = CGColor(colorSpace: colorspace, components: newComponents) else {
            return
        }
        
        // 填充阴影
        ctx.setStrokeColor(UIColor.clear.cgColor)
        ctx.setFillColor(innerShadowColorWithMultipliedAlpha)
        ctx.setShadow(offset: innerShadowOffset, blur: innerShadowRadius, color: innerShadowColorWithMultipliedAlpha)
        ctx.addPath(shadowPath)
        ctx.addPath(shadowPath)
        ctx.fillPath()
    }
}
