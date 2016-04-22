//
//  ViewController.swift
//  test CGAffineTransform
//
//  Created by Will on 4/22/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var aSlider: UISlider!
    @IBOutlet var bSlider: UISlider!
    @IBOutlet var cSlider: UISlider!
    @IBOutlet var dSlider: UISlider!
    @IBOutlet var txSlider: UISlider!
    @IBOutlet var tySlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        aSlider.value = 1
        dSlider.value = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderVauleChanged(sender: AnyObject) {
        print((sender as! UISlider).value)
        imageView.transform = CGAffineTransform(a: ch(aSlider), b: ch(bSlider), c: ch(cSlider), d: ch(dSlider), tx: ch(txSlider, range: 100), ty: ch(tySlider, range: 100))
    }

    func ch(slider: UISlider, range: CGFloat = 1) -> CGFloat {
        return CGFloat(slider.value * 2 - 1) * range
    }
}

