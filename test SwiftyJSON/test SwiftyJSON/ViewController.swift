//
//  ViewController.swift
//  test SwiftyJSON
//
//  Created by Will on 5/6/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class JLXPictureResult: NSObject {
    
    var normal: String?
    var big: String?
    var middle: String?
    var small: String?
    
    init(json: JSON) {
        super.init()
        
        self.normal = json["normal"].string
        self.big = json["big"].string
        self.middle = json["middle"].string
        self.small = json["small"].string
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pic = JLXPictureResult(json: JSON.null)
        print(pic)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

