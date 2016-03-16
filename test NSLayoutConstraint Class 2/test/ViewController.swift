//
//  ViewController.swift
//  test
//
//  Created by Will on 3/5/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let v = CustomToolBar(frame: CGRect(x: 0, y: 20, width: UIScreen.mainScreen().bounds.width, height: 30) )
        self.view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

