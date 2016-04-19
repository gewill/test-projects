//
//  ViewController.swift
//  test
//
//  Created by Will on 4/19/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var seconds = 0
    var myTimer : NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTimer = NSTimer(timeInterval: 1, target: self, selector: #selector(self.refresh(_:)), userInfo: nil, repeats: true)
        myTimer!.fire()
        
    }
    
    func refresh(sender: AnyObject) {
        print(seconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

