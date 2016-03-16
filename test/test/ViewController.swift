//
//  ViewController.swift
//  test
//
//  Created by Will on 3/10/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func pushNew(sender: AnyObject) {
        let  vc = ViewController()
        vc.view.backgroundColor = UIColor ( red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0 )
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

