//
//  InternetPlusViewController.swift
//  5News
//
//  Created by Will on 1/4/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

class InternetPlusViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UITableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SmallPictureCell") as? SmallPictureCell
        
        if (cell == nil) {
            cell = SmallPictureCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "SmallPictureCell")
        }
        
        cell?.coverImage.sd_setImageWithURL(NSURL.init(string: "http://img.jiemian.com/101/original/20160104/14518832866988500_a640x320.jpg"))
        cell?.title.text = "“西超双雄”联赛遇阻，马竞能否复制奇迹？"
        cell?.author.text = "牛其昌"
        cell?.publishTime.text = "12分钟前"
        
        return cell!
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }


}
