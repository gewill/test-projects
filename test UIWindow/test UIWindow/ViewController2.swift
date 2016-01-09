//
//  ViewController.swift
//  test UIWindow
//
//  Created by Will on 1/9/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button2 = UIButton.init(type: .Custom)
        button2.frame = CGRectMake(8, 100, 400, 44)
        button2.setTitle("Button2: Dismiss self window", forState: .Normal)
        button2.backgroundColor = UIColor(red: 0.502, green: 0.502, blue: 0.0, alpha: 1.0)
        button2.addTarget(self, action: "Button2Function", forControlEvents: .TouchUpInside)
        self.view.addSubview(button2)
    }
    
    func Button2Function() {
        print("Button2 22222222")
        self.view.window?.frame = CGRectZero
        self.view.removeFromSuperview()
    }
    
    
}

