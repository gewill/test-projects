//
//  ViewController.swift
//  test-SwiftyUserDefaults
//
//  Created by Will on 5/11/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Defaults[.defaultVideoUrl] {
           print(url)
        } else {
            print("File: \(#file), function: \(#function), line: \(#line) -> ")
            Defaults[.defaultVideoUrl] = "wewe"
        }

        if let url = Defaults[.defaultVideoUrl] {
            print(url)
        } else {
            print("File: \(#file), function: \(#function), line: \(#line) -> ☄")
        }
        
        Defaults[.buildNubmer] = (NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String
        print(Defaults[.buildNubmer])
        
        let lee = "String"
        Defaults[lee] = "2"
        print(Defaults[lee])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

