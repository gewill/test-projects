//
//  ViewController.swift
//  test
//
//  Created by Will on 3/4/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

func dictionaryOfNames(arr: UIView ...) -> [String: UIView] {
    var d = [String: UIView]()
    for (ix, v) in arr.enumerate() {
        d["v\(ix+1)"] = v
    }
    return d
}

class ViewController: UIViewController {
    @IBOutlet var dd: NSLayoutConstraint!

    @IBOutlet var xxx: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let container = UIView(frame: self.view.bounds)
        container.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.252461163294798)
        self.view.addSubview(container)

        let aLine = UIView()
        aLine.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        aLine.backgroundColor = UIColor(red: 0.6667, green: 0.0742, blue: 0.6667, alpha: 1.0)
        container.addSubview(aLine)

        aLine.translatesAutoresizingMaskIntoConstraints = false

        let i = 4

        switch (i) {
        case 0:
            // MARK:-  superview addConstraint
            container.addConstraint(NSLayoutConstraint(item: aLine, attribute: .Leading, relatedBy: .Equal, toItem: container, attribute: .Leading, multiplier: 1, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: aLine, attribute: .Trailing, relatedBy: .Equal, toItem: container, attribute: .Trailing, multiplier: 1, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: aLine, attribute: .Top, relatedBy: .Equal, toItem: container, attribute: .Top, multiplier: 1, constant: 0))
            aLine.addConstraint(NSLayoutConstraint(item: aLine, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20))
        case 1:
            // MARK:- iOS 6
            container.addConstraints([
                NSLayoutConstraint(item: aLine, attribute: .Leading, relatedBy: .Equal, toItem: container, attribute: .Leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: aLine, attribute: .Trailing, relatedBy: .Equal, toItem: container, attribute: .Trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: aLine, attribute: .Top, relatedBy: .Equal, toItem: container, attribute: .Top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: aLine, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20),
            ])
        case 2:
            // MARK:- active = true
            if #available(iOS 8.0, *) {
                NSLayoutConstraint(item: aLine, attribute: .Leading, relatedBy: .Equal, toItem: container, attribute: .Leading, multiplier: 1, constant: 0).active = true
                NSLayoutConstraint(item: aLine, attribute: .Trailing, relatedBy: .Equal, toItem: container, attribute: .Trailing, multiplier: 1, constant: 0).active = true
                NSLayoutConstraint(item: aLine, attribute: .Top, relatedBy: .Equal, toItem: container, attribute: .Top, multiplier: 1, constant: 0).active = true
                NSLayoutConstraint(item: aLine, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20).active = true
            } else {
                // Fallback on earlier versions
            }

        case 3:
            // MARK:- NSLayoutConstraint.activateConstraints
            if #available(iOS 8.0, *) {
                NSLayoutConstraint.activateConstraints([
                    NSLayoutConstraint(item: aLine, attribute: .Leading, relatedBy: .Equal, toItem: container, attribute: .Leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: aLine, attribute: .Trailing, relatedBy: .Equal, toItem: container, attribute: .Trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: aLine, attribute: .Top, relatedBy: .Equal, toItem: container, attribute: .Top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: aLine, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 20),
                ])
            } else {
                // Fallback on earlier versions
            }
        case 4:

            let d = dictionaryOfNames(aLine)
            container.addConstraints([
                NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1(20)]", options: [], metrics: nil, views: d),
                NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: [], metrics: nil, views: d),
            ].flatten().map { $0 })
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
