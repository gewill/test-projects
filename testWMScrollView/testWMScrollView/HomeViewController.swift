//
//  HomeViewController.swift
//  5News
//
//  Created by Will on 1/4/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController, WMLoopViewDelegate {
 
    var loopView: WMLoopView!
    var loopViewTitiles = ["巴特勒下半场独得40分，打破了由乔丹保持的公牛队史半场得分纪录。", "莎娃卫冕冠军", "Ailon Mask"]
    var loopViewURLs = ["http://img.jiemian.com/101/original/20160104/14518759778535300_a280x210.jpg", "http://img.jiemian.com/101/original/20160104/14518832866988500_a640x320.jpg", "http://img.jiemian.com/101/original/20160104/145189279252183300_a640x320.jpg"]
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.showsVerticalScrollIndicator = false
        
        loopView = WMLoopView.init(frame: CGRectMake(0, 0, screenWidth, screenWidth / 1.78), images: loopViewURLs, autoPlay: true, delay: 5)
        loopView.delegate = self
        
        let placeHolderView = UIView.init(frame: CGRectMake(0, 0, screenWidth, screenWidth / 1.78))
        placeHolderView.addSubview(loopView)
        tableView.tableHeaderView = loopView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UITableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("BigPictureCell") as? BigPictureCell
        
        if (cell == nil) {
            cell = BigPictureCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "BigPictureCell")
        }
        
        cell?.coverImage.sd_setImageWithURL(NSURL.init(string: "http://img.jiemian.com/101/original/20160104/14518759778535300_a280x210.jpg"))
        cell?.title.text = "巴特勒下半场独得40分，打破了由乔丹保持的公牛队史半场得分纪录。"
        cell?.author.text = "NBA"
        cell?.publishTime.text = "2小时前"
        
        return cell!
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.navigationController)
    }
    
    // WMLoopViewDelegate
    func loopViewDidSelectedImage(loopView: WMLoopView!, index: Int32) {
        print(index)
    }
    
    
}
