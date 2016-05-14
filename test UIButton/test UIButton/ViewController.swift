//
//  ViewController.swift
//  test UIButton
//
//  Created by Will on 5/14/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var buttonState: UILabel!

    @IBOutlet var focusLabel: UILabel!
    var timer: NSTimer!

    var isFriend = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        button.setTitle("enabled", forState: .Normal)

        button.setTitle("highlight", forState: .Highlighted)
        button.setTitle("disabled", forState: .Disabled)
        button.setTitle("selected", forState: .Selected)
        button.setTitle("Focused", forState: .Focused)
        button.setTitle("Application", forState: .Application)
        button.setTitle("Reserved", forState: .Reserved)

        timer = NSTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateButtonState), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        timer.fire()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClick(sender: AnyObject) {
        self.isFriend = !self.isFriend
        button.setTitle("\(isFriend)", forState: .Normal)

    }

    @IBAction func enableButtonClick(sender: AnyObject) {
        button.enabled = !button.enabled
    }

    @IBAction func selectedButtonClick(sender: AnyObject) {
        button.selected = !button.selected
    }

    @IBAction func highlightButtonClick(sender: AnyObject) {
        button.highlighted = !button.highlighted
    }

    func updateButtonState() {
        var stateDescription = "not catch"
        switch button.state {
        case UIControlState.Normal:
            stateDescription = "Normal"
        case UIControlState.Highlighted:
            stateDescription = "Highlighted"
        case UIControlState.Disabled:
            stateDescription = "Disabled"
        case UIControlState.Selected:
            stateDescription = "Selected"
        case UIControlState.Focused:
            stateDescription = "Focused"
        case UIControlState.Application:
            stateDescription = "Application"
        case UIControlState.Reserved:
            stateDescription = "Reserved"
        default:
            break
        }

        self.buttonState.text = "button.state: \(button.state) \(stateDescription),  focused: \(button.focused),  "

    }

}

