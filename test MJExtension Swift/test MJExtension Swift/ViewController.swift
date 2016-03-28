//
//  ViewController.swift
//  test MJExtension Swift
//
//  Created by Will on 1/8/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("top_news", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)

        let re = Response.mj_objectWithKeyValues(json)
        print(re.state)

        let res = re.result
        print(res.lastTime)

        let ban : NSArray = Article.mj_objectArrayWithKeyValuesArray(res.banners)

        for var i = 0; i < ban.count; i++ {
            if let banner = ban[i] as? Article {
                print("id: \(banner.articleId) , sex: ---- \(banner.sex)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

