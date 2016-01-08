//
//  ViewController.swift
//  testWMScrollView
//
//  Created by Will on 1/5/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var newsPageControllerClasses: [UIViewController.Type] = [HomeViewController.self, InternetPlusViewController.self, ColumnsViewController.self]
    var newsThemes = ["首页", "互联网+", "专栏"]
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(sender: AnyObject) {

        

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "CellID")
        }
        cell?.textLabel?.text = "to page controller"
        
        return cell!
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let pageController = WMPageController(viewControllerClasses: newsPageControllerClasses, andTheirTitles: newsThemes)
        pageController.titleSizeSelected = 15
        pageController.pageAnimatable = true
        pageController.menuViewStyle = .Line
        pageController.titleColorSelected = UIColor.redColor()
        pageController.titleColorNormal = UIColor.blackColor()
        pageController.progressColor = UIColor.redColor()
        pageController.itemsWidths = [60, 80, 60]
        pageController.postNotification = false
        pageController.otherGestureRecognizerSimultaneously = true

    }

}

