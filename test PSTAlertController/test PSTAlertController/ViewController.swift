//
//  ViewController.swift
//  test PSTAlertController
//
//  Created by Will Ge on 11/4/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var go: UIButton!

    @IBAction func gogo(sender: AnyObject) {
        let alert = PSTAlertController(title: "请输入你所在的地区", message: nil, preferredStyle: PSTAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in })
        alert.addCancelActionWithHandler(nil)
        alert.addAction(PSTAlertAction(title: "确认", style: PSTAlertActionStyle.Default, handler: { (alertAction) -> Void in
            print("确认")
        }))
        alert.showWithSender(nil, controller: self, animated:true, completion: nil)
    }

}

