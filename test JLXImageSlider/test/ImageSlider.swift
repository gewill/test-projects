//
//  JLXImageSlider.swift
//
//
//  Created by Will on 3/29/16.
//  Copyright © 2016 . All rights reserved.
//

import UIKit
import AVFoundation

class ImageSlider: UIView, UIScrollViewDelegate {

    var imageViewsContainer: UIView!
    var scrollView: UIScrollView!
    private var splitLine: UIView!

    var imageCount: Int = 11

    private var imageWidth: CGFloat!
    private var imageGenerator: AVAssetImageGenerator!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {

        imageWidth = bounds.height / 9 * 16

        self.backgroundColor = UIColor(red: 0.902, green: 0.902, blue: 0.902, alpha: 1.0)
        self.clipsToBounds = true

        imageViewsContainer = UIView()
        imageViewsContainer.frame = CGRect(x: 0, y: 0, width: (imageWidth * CGFloat(imageCount) + bounds.width), height: bounds.height)
        imageViewsContainer.backgroundColor = UIColor.clearColor()

        scrollView = UIScrollView()
        scrollView.contentSize = imageViewsContainer.bounds.size
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.maximumZoomScale = 1
        scrollView.minimumZoomScale = 1
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.delegate = self

        scrollView.addSubview(imageViewsContainer)
        self.addSubview(scrollView)

        splitLine = UIView()
        splitLine.frame = CGRect(x: bounds.width / 2 - 2, y: 0, width: 4, height: bounds.height)
        splitLine.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.502, alpha: 1.0)
        self.addSubview(splitLine)

        splitLine.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        var previousImageView: UIImageView? = nil

        for i in 0 ... (imageCount - 1) {

            let imageView = UIImageView()
            imageView.tag = i

            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            imageViewsContainer.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false

            self.imageViewsContainer.addConstraints([
                NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v]-0-|", options: [], metrics: nil, views: ["v": imageView])
                ].flatten().map { $0 })

            if previousImageView == nil { // first one, pin to top
                self.imageViewsContainer.addConstraints([
                    NSLayoutConstraint.constraintsWithVisualFormat("H:|-p-[v(w)]", options: [], metrics: ["p": UIScreen.mainScreen().bounds.width / 2, "w": self.imageWidth], views: ["v": imageView])
                    ].flatten().map { $0 })
            } else { // all others, pin to previous
                self.imageViewsContainer.addConstraints([
                    NSLayoutConstraint.constraintsWithVisualFormat(
                        "H:[pv]-0-[v(w)]", options: [], metrics: ["w": self.imageWidth], views: ["pv": previousImageView!, "v": imageView])
                    ].flatten().map { $0 })
            }
            previousImageView = imageView
        }
    }

    func setImagesByVideoUrl(url: NSURL) {

        let asset = AVAsset(URL: url)

        imageGenerator = AVAssetImageGenerator(asset: asset)

        var times = [NSValue]()
        for i in 0 ... (imageCount - 1) {
            let seconds = CMTimeGetSeconds(asset.duration)
            let time = CMTime(seconds: seconds * Double(i) / Double(imageCount), preferredTimescale: 600)
            times.append(NSValue(CMTime: time))
        }

        var imageArray = [UIImage]()
        imageGenerator.generateCGImagesAsynchronouslyForTimes(times) { (requestedTime, image, actualTime, result, error) in

            switch (result) {
            case AVAssetImageGeneratorResult.Succeeded:

                imageArray.append(UIImage(CGImage: image!))

                if imageArray.count == self.imageCount {
                    dispatch_async(dispatch_get_main_queue(), {

                        for i in 0 ... self.imageCount - 1 {
                            for v in self.imageViewsContainer.subviews {
                                if v is UIImageView && v.tag == i {

                                    (v as! UIImageView).image = imageArray[i]
                                }
                            }
                        }

                        self.imageViewsContainer.setNeedsDisplay()
                    })
                }
            default:
                break
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        splitLine.frame = CGRect(x: bounds.width / 2 - 2, y: 0, width: 4, height: bounds.height)
        imageViewsContainer.frame = CGRect(x: 0, y: 0, width: (imageWidth * CGFloat(imageCount) + bounds.width), height: bounds.height)
        scrollView.contentSize = imageViewsContainer.bounds.size
        scrollView.frame = bounds
    }

    // MARK: - UIScrollViewDelegate

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageViewsContainer
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("File: \(#file), function: \(#function), line: \(#line) -> \(scrollView.contentOffset)")
    }

    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}
