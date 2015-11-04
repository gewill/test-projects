//
//  ViewController.swift
//  test
//
//  Created by Will Ge on 10/22/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

import UIKit

@available(iOS 8.0, *)
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ss(sender: UIButton) {
        func configurationTextField(textField: UITextField!)
        {
            print(textField.text)
            
        }
        
        
        func handleCancel(alertView: UIAlertAction!)
        {
            print("User click Cancel button")
            
        }
        
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("User click Ok button")
            
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
    }

    @IBAction func useUIAlertView(sender: AnyObject) {
    }

}

