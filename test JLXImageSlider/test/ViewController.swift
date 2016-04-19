//
//  ViewController.swift
//  test
//
//  Created by Will on 3/29/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func click(sender: AnyObject) {
        print(sender)
    }

    var v: ImageSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        v = ImageSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
        self.view.addSubview(v)
        v.setImagesByVideoUrl(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("yishengsuoai", ofType: ".mp4")!))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

