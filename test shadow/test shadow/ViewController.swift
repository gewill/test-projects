//
//  ViewController.swift
//  test shadow
//
//  Created by Will on 5/6/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

func addShadow(views: UIView ...) {
    for (_, view) in views.enumerate() {
        view.layer.shadowColor = UIColor.grayColor().CGColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSizeZero
        view.layer.shadowRadius = 0
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).CGPath
        view.layer.shouldRasterize = true
    }
}

class ViewController: UIViewController {

    @IBOutlet var backgroudView: UIView!

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

//        addShadow(label, button)
        backgroudView.backgroundColor = UIColor (red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        backgroudView.alpha = 0.3

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func colorChanged(sender: UISlider) {
        print(sender.value)
        backgroudView.backgroundColor = UIColor (red: 0.0, green: 0.0, blue: 0.0, alpha: CGFloat(sender.value))
    }

    @IBAction func slideChanged(sender: UISlider) {
        print(sender.value)
        backgroudView.alpha = CGFloat(sender.value)
    }
}

