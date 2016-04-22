//
//  ViewController.swift
//  test RAReorderableLayout
//
//  Created by Will on 4/21/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RAReorderableLayoutDataSource, RAReorderableLayoutDelegate, EditVideoCellDelegate {
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - collectionView delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EditVideoCell", forIndexPath: indexPath) as! EditVideoCell

        cell.coverImageView.image = UIImage(named: "Sample0")
        cell.delegate = self
        return cell
    }

    // TODO: - Add select status
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("function: \(#function) -> \(indexPath.item)")
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print(" function: \(#function) -> \(indexPath.row) ")
    }

    // MARK: - RAReorderableLayout delegate datasource

    func collectionView(collectionView: UICollectionView, atIndexPath: NSIndexPath, didMoveToIndexPath toIndexPath: NSIndexPath) {
        print("File: \(#file), function: \(#function), line: \(#line) -> \(toIndexPath)")
    }
    
    
    // MARK: - EditVideoCellDelegate
    func didClickDeleteButton(cell: EditVideoCell) {
        print("File: \(#file), function: \(#function), line: \(#line) -> \(cell)")
    }
}

