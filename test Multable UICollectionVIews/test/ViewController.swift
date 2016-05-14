//
//  ViewController.swift
//  test
//
//  Created by Will on 4/28/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RAReorderableLayoutDataSource, RAReorderableLayoutDelegate {

    @IBOutlet var cv1: UICollectionView!
    @IBOutlet var cv2: UICollectionView!

    @IBOutlet var layout1: RAReorderableLayout!
    @IBOutlet var layout2: RAReorderableLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cv1.dataSource = self
        cv2.dataSource = self

        cv1.delegate = self
        cv2.delegate = self

        cv1.backgroundColor = UIColor ( red: 0.4, green: 1.0, blue: 0.8, alpha: 1.0 )
        cv2.backgroundColor = UIColor.clearColor()
        
        layout1.itemSize = cv1.bounds.size
        layout2.itemSize = cv2.bounds.size

        
        cv1.pagingEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 5

    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if collectionView == cv1 {
            let cell1 = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath)
            cell1.backgroundColor = UIColor.purpleColor()
            return cell1

        } else {
            let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath)
            cell2.backgroundColor = UIColor.redColor()
            return cell2
        }

    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == cv1 {
            print("cv1")
        } else {
            print("cv2")
        }
    }

}

