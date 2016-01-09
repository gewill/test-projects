//
//  ViewController.swift
//  test UIWindow
//
//  Created by Will on 1/9/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var Button1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Button1 = UIButton.init(type: .Custom)
        Button1.frame = CGRectMake(8, 100, 80, 44)
        Button1.setTitle("Button1", forState: .Normal)
        Button1.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        Button1.addTarget(self, action: "Button1Function", forControlEvents: .TouchUpInside)
        self.view.addSubview(Button1)
    }
    
    func Button1Function() {
        print("Button1 1111")
    }
    
    
}

