//
//  BaseTableViewController.swift
//  5News
//
//  Created by Will on 1/4/16.
//  Copyright © 2016 5News. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "BigPictureCell", bundle: nil), forCellReuseIdentifier: "BigPictureCell")
        tableView.registerNib(UINib(nibName: "SmallPictureCell", bundle: nil), forCellReuseIdentifier: "SmallPictureCell")
        
        tableView.estimatedRowHeight = 104
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    // UITableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "CellID")
        }
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.text = "0"
        
        return cell!
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
