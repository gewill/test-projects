//
//  ViewController.swift
//  test Core Animation
//
//  Created by Will on 3/16/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    let layer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addImageLayer()
    }

    func addImageLayer() {

        layer.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        layer.position = CGPoint(x: 100, y: 100)
        let image = UIImage(named: "yanFei")!
        layer.contents = image.CGImage

        self.view.layer.addSublayer(layer)
    }

    @IBAction func stopButtonClick(sender: AnyObject) {
    }
    @IBAction func firstButtonClick(sender: AnyObject) {
        layer.opacity = 0
    }
    @IBAction func secendButtonClick(sender: AnyObject) {
        // Just disable current run loop transaction
//        CATransaction.setDisableActions(true)

        CATransaction.setAnimationDuration(2)
        layer.opacity = 1
        layer.position = CGPoint(x: 100, y: 400)
    }
    @IBAction func thirdButtonClick(sender: AnyObject) {
        CATransaction.setAnimationDuration(5)
        layer.position = CGPoint(x: 0, y: UIScreen.mainScreen().bounds.height)
        layer.opacity = 0
    }

    @IBAction func fourthButtonClick(sender: AnyObject) {

        layer.position = CGPoint(x: layer.position.x, y: 400)

        let drop = CABasicAnimation(keyPath: "position.y")
        drop.fromValue = 30
        drop.toValue = 400
        drop.duration = 5
        drop.delegate = self
//        drop.beginTime = CACurrentMediaTime() + 0.5
        layer.addAnimation(drop, forKey: nil)
    }
    @IBAction func fivethButtonClick(sender: AnyObject) {

        let shake = CAKeyframeAnimation(keyPath: "position.x")
        // values or path
        shake.values = [0, 10, -10, 10, 0]
        shake.keyTimes = [0, 1 / 6.0, 3 / 6.0, 5 / 6.0, 1]
        shake.duration = 0.4

        shake.additive = true
        
        shake.delegate = self

        layer.addAnimation(shake, forKey: "shake")
    }

    @IBAction func sixthButtonClick(sender: AnyObject) {

        let boundingRect = CGRect(x: -50, y: -50, width: 100, height: 100)

        let orbit = CAKeyframeAnimation(keyPath: "position")
        orbit.path = CGPathCreateWithEllipseInRect(boundingRect, nil)
        orbit.duration = 4
        orbit.additive = true
        orbit.repeatCount = Float.infinity
        orbit.calculationMode = kCAAnimationPaced
        orbit.rotationMode = kCAAnimationRotateAuto

        layer.addAnimation(orbit, forKey: "orbit")
    }

    @IBAction func seventhButtonClick(sender: AnyObject) {

        layer.position = CGPoint(x: 300, y: layer.position.y)

        let timing = CABasicAnimation(keyPath: "position.x")
        timing.fromValue = 30
        timing.toValue = 300
        timing.duration = 2

//        timing.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        timing.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0, 0.9, 0.7)
        layer.addAnimation(timing, forKey: "timing")
    }

    @IBAction func eighthButtonClick(sender: AnyObject) {

        let zPosistion = CABasicAnimation(keyPath: "zPosition")
        zPosistion.fromValue = -1
        zPosistion.toValue = 1
        zPosistion.duration = 1.2

        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
        rotation.values = [0, 0.14, 0]
        rotation.duration = 1.2
        rotation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]

        let position = CAKeyframeAnimation(keyPath: "position")
        position.values = [NSValue(CGPoint: CGPointZero), NSValue(CGPoint: CGPoint(x: 110, y: -20)), NSValue(CGPoint: CGPointZero)]
        position.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        position.duration = 1.2
        position.additive = true

        let group = CAAnimationGroup()
        group.animations = [zPosistion, rotation, position]
        group.duration = 1.2
        group.beginTime = CACurrentMediaTime() + 0.5

        layer.addAnimation(group, forKey: nil)

        layer.zPosition = 1
    }
}

extension ViewController {
    override func animationDidStart(anim: CAAnimation) {
        print(anim)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print(anim)
    }
}