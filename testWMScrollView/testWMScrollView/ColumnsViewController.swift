//
//  ColumnsViewController.swift
//  5News
//
//  Created by Will on 1/4/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

class ColumnsViewController: BaseTableViewController {

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
        return 5;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("BigPictureCell") as? BigPictureCell
        
        if (cell == nil) {
            cell = BigPictureCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "BigPictureCell")
        }
        
        cell?.coverImage.sd_setImageWithURL(NSURL.init(string: "http://img.jiemian.com/101/original/20160104/145189279252183300_a640x320.jpg"))
        cell?.title.text = "为了重温大满贯冠军的美好 莎拉波娃新赛季将“松绑”赛程"
        cell?.author.text = "Jack Ma"
        cell?.publishTime.text = "33分钟前"
        
        return cell!
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
}

