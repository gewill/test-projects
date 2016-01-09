//
//  ViewController.swift
//  test UIWindow
//
//  Created by Will on 1/9/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var Button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Button2 = UIButton.init(type: .Custom)
        Button2.frame = CGRectMake(8, 100, 400, 44)
        Button2.setTitle("Button2: Dismiss self window", forState: .Normal)
        Button2.backgroundColor = UIColor(red: 0.502, green: 0.502, blue: 0.0, alpha: 1.0)
        Button2.addTarget(self, action: "Button2Function", forControlEvents: .TouchUpInside)
        self.view.addSubview(Button2)
    }
    
    func Button2Function() {
        print("Button2 22222222")
        self.view.window?.frame = CGRectZero
        self.view.removeFromSuperview()
    }
    
    
}

