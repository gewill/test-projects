//
//  ViewController.swift
//  test UIWindow
//
//  Created by Will on 1/9/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var button1: UIButton!
    var button3: UIButton!
    
    var window3: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1 = UIButton.init(type: .Custom)
        button1.frame = CGRectMake(8, 100, 400, 44)
        button1.setTitle("Button1: Call back another window", forState: .Normal)
        button1.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        button1.addTarget(self, action: "button1Function", forControlEvents: .TouchUpInside)
        self.view.addSubview(button1)
        
        button3 = UIButton.init(type: .Custom)
        button3.frame = CGRectMake(8, 200, 400, 44)
        button3.setTitle("Button3: Create a mini window", forState: .Normal)
        button3.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        button3.addTarget(self, action: "button3Function", forControlEvents: .TouchUpInside)
        self.view.addSubview(button3)
        
    }
    
    func button1Function() {
        print("Button1 1111")
        UIApplication.sharedApplication().windows[1].frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 200, UIScreen.mainScreen().bounds.width - 8, 300)
        UIApplication.sharedApplication().windows[1].rootViewController = ViewController2()
    }
    
    func button3Function() {
        
        let x = CGFloat(arc4random_uniform(400))
        let y = CGFloat(arc4random_uniform(600))
        
        window3 = UIWindow(frame: CGRectMake(x, y, 44, 44))
        window3!.rootViewController = UIViewController()
        window3!.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        window3!.makeKeyAndVisible()
    }
    
}

