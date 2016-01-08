//
//  ViewController.swift
//  test ScrollViewDelegate
//
//  Created by Will on 12/31/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 3, UIScreen.mainScreen().bounds.height * 3)
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 0.1
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.delegate = self
    }

    // UIScrollViewDelegate
//    func scrollViewDidZoom(scrollView: UIScrollView) {
//        print("scrollViewDidZoom")
//    }
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print("scrollViewDidScroll")
//    }
//    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
//        print("scrollViewDidScrollToTop")
//    }
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
//    }
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        print("scrollViewDidEndDecelerating")
//    }
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        print("scrollViewWillBeginDecelerating")
//    }
//    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//        print("scrollViewDidEndScrollingAnimation")
//    }
//    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
//        print("scrollViewShouldScrollToTop")
//        return true
//    }
//    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
//        print("scrollViewWillBeginZooming")
//    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
//    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
//        print("scrollViewDidEndZooming")
//    }
//    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("scrollViewWillEndDragging")
//    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        print("viewForZoomingInScrollView")
        return image
    }
    
}

