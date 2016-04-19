//
//  ViewController.swift
//  test return swift
//
//  Created by Will on 4/18/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		dispatch_async(dispatch_get_main_queue()) {
			if 2 > 3 {
                
				print("11111")
                return
                    
                print("222222")
			}
            print("333333")
		}
        print("4444444")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

