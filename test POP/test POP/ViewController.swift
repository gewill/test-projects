//
//  ViewController.swift
//  test POP
//
//  Created by Will on 4/23/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipLeft(_:)))
        swipeLeft.direction = .Left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipRight(_:)))
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func swipRight(sender: AnyObject) {
        let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        anim.springSpeed = 1
        anim.velocity = 1
        anim.toValue = 40
        imageView.pop_addAnimation(anim, forKey: nil)
        
        let name = "Sample" + String(arc4random_uniform(30) + 1)
        imageView.image = UIImage(named: name)
    }
    
    func swipLeft(sender: AnyObject) {
        let totalDuration: CFTimeInterval = 2.65
        let left = CABasicAnimation(keyPath: "position.x")
        
        let x = imageView.frame.origin.x
        left.fromValue = x
        left.toValue = x - UIScreen.mainScreen().bounds.width
        left.duration = totalDuration
        left.beginTime = CACurrentMediaTime()
        left.delegate = self
        
        imageView.layer.addAnimation(left, forKey: nil)
        
        let name = "Sample" + String(arc4random_uniform(30) + 1)
        imageView.image = UIImage(named: name)
    }
    
    override func animationDidStart(anim: CAAnimation) {
        print("start")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("stop \(flag)")
    }

}

