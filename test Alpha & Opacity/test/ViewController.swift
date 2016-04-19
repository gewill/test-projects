//
//  ViewController.swift
//  test
//
//  Created by Will on 4/18/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.sharedApplication().windows[0].backgroundColor = UIColor.whiteColor()

        self.view.backgroundColor = UIColor.blueColor()
        dispatch_async(dispatch_get_main_queue()) {
            self.view.layer.opacity = 0
            UIView.animateWithDuration(2.25, animations: {
                self.view.layer.opacity = 1
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func alphaSliderValueChanged(sender: UISlider) {
        self.view.alpha = CGFloat(sender.value)
        print(self.view.alpha)
    }
    @IBAction func opacitySliderValueChanged(sender: UISlider) {
        self.view.layer.opacity = sender.value
        print(self.view.layer.opacity)
    }
}
