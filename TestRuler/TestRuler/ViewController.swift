//
//  ViewController.swift
//  TestRuler
//
//  Created by Will Ge on 8/2/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

import UIKit
import Ruler

class ViewController: UIViewController {

    @IBOutlet weak var myText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = Ruler.match(.iPhoneWidths(10, 20, 30))
        
        let height = Ruler.match(.iPhoneHeights(5, 10, 20, 30))
        
        let universalWidth = Ruler.match(.UniversalWidths(10, 20, 30, 40))
        
        let universalHeight = Ruler.match(.UniversalHeights(5, 10, 20, 30, 40))
        
        print(width,height,universalWidth,universalHeight)
        
        
        var testRulerLabel = self.view.viewWithTag(1) as! UILabel
        testRulerLabel.text = "\(width),\(height),\(universalWidth),\(universalHeight)"
        testRulerLabel.textColor = UIColor ( red: 0.6982, green: 0.2238, blue: 1.0, alpha: 1.0 )
        testRulerLabel.adjustsFontSizeToFitWidth = true
        
        
        
        
        self.myText.text = "iOS"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

