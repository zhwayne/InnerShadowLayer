//
//  ViewController.swift
//  InnerShadowLayer
//
//  Created by wayne on 15/6/12.
//  Copyright © 2015年 wayne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myView                      = UIView(frame: CGRectMake(0, 0, 280, 280))
        myView.layer.backgroundColor    = UIColor.hexColor(0xeeeeee).CGColor
        myView.center                   = self.view.center
        myView.layer.cornerRadius       = myView.bounds.size.width / 2
        myView.layer.shouldRasterize    = true
        myView.layer.contentsScale      = UIScreen.mainScreen().scale
        myView.layer.rasterizationScale = UIScreen.mainScreen().scale

        
        let shadowLayer          = InnerShadowLayer()
        shadowLayer.frame        = myView.bounds
        shadowLayer.cornerRadius = shadowLayer.bounds.size.width / 2
        shadowLayer.innerShadowOffset  = CGSizeMake(4, 4)
        shadowLayer.innerShadowOpacity = 0.4
        shadowLayer.innerShadowRadius  = 16
        myView.layer.addSublayer(shadowLayer)
        
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

