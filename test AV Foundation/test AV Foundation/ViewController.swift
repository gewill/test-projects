//
//  ViewController.swift
//  test AV Foundation
//
//  Created by Will on 3/22/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import AssetsLibrary
import Photos
import AVFoundation

struct videoInfo {
    var url: NSURL
    var startTime: CMTime?
    var endTime: CMTime?
    var coverImage: UIImage?
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

//    var moviePlayer: MPMoviePlayerController!
    var imageGenerator: AVAssetImageGenerator!

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!

    var totalDuration: CMTime = kCMTimeZero

    var selectedStartTime = kCMTimeZero
    var selectedEndTime = kCMTimeZero
    var selectedDuration = kCMTimeZero

    var previousLowerValue: Double?
    var previousUpperValue: Double?

    var rangeSliderImageArray = [UIImage]()

    // MARK: - url observer
    var movieUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("yishengsuoai", ofType: ".mp4")!)
    {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                self.changePlayingVideoByURL(self.movieUrl)
                self.getImagesInVideoByURLAndSetToRangeSlider(self.movieUrl)
            }
        }
    }

    var videoUrlArray = [NSURL]()
    {
        didSet {
            // update display videos
            print("File: \(#file), function: \(#function), line: \(#line) -> ")
            print(videoUrlArray.last)

            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView.reloadData()
            }
        }
    }

    var isFirstTimeAddImageToRangeSlider = true
    var asset: AVAsset!

    @IBOutlet var rangeSlider: RangeSlider!

    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var durationTimeLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!

    let screenWidth = UIScreen.mainScreen().bounds.width
    let thumbnailImageViewWidth = CGFloat(Int((UIScreen.mainScreen().bounds.width - 16 * 2) / 12))

    @IBOutlet var rangeSliderConstraintHeight: NSLayoutConstraint!
    @IBOutlet var rangeSliderConstraintWidth: NSLayoutConstraint!

    @IBOutlet var videoViewPlaceHolderConstraintHeight: NSLayoutConstraint!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!

    @IBOutlet var imageViewsContainer: UIView!
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.videoUrlArray.append(movieUrl)

        self.setupPlayer()

        self.setupRangeSlider()

        self.setupToolbar()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: [])
        _ = try? AVAudioSession.sharedInstance().setActive(true, withOptions: [])
    }

    // MARK: -  setups
    func setupPlayer() {

        videoViewPlaceHolderConstraintHeight.constant = screenWidth * 9 / 16
        // 1 - MPMoviePlayerController
//        self.moviePlayer = MPMoviePlayerController(contentURL: movieUrl)
//        if let player = self.moviePlayer {
//            player.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width * 9 / 16)
//            player.view.sizeToFit()
//            player.scalingMode = MPMovieScalingMode.Fill
//            player.fullscreen = false
//            player.controlStyle = MPMovieControlStyle.None
//            player.movieSourceType = MPMovieSourceType.File
//            player.repeatMode = MPMovieRepeatMode.One
//            player.play()
//
//            self.view.addSubview(player.view)
//
        // 2 - Assets item
//        let asset = AVURLAsset(URL: movieUrl, options: nil)
//        let item = AVPlayerItem(asset: asset)
//        let p = AVPlayer(playerItem: item)
//        self.player = p // might need a reference later
//        let lay = AVPlayerLayer(player: p)
//        lay.frame = CGRectMake(0, 44, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width * 9 / 16)
//        self.playerLayer = lay
//
//        lay.addObserver(self, forKeyPath: "readyForDisplay", options: [], context: nil)

        // 3 - Assets compostion
        let asset = AVURLAsset(URL: movieUrl)
        let composion = AVMutableComposition()
        self.totalDuration = asset.duration
        let range = CMTimeRange(start: kCMTimeZero, duration: asset.duration)
        _ = try? composion.insertTimeRange(range, ofAsset: asset, atTime: kCMTimeZero)
        let item = AVPlayerItem(asset: composion)
        let p = AVPlayer(playerItem: item)
        self.player = p // might need a reference later
        let lay = AVPlayerLayer(player: p)
        lay.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width * 9 / 16)
        self.playerLayer = lay

        self.view.layer.addSublayer(self.playerLayer)

//        lay.addObserver(self, forKeyPath: "readyForDisplay", options: [], context: nil)
    }

//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String: AnyObject]?, context: UnsafeMutablePointer<()>) {
//        if keyPath == "readyForDisplay" {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.finishConstructingInterface()
//            })
//        }
//    }
//
//    func finishConstructingInterface() {
//        if (!self.playerLayer.readyForDisplay) {
//            return
//        }
//
//        self.playerLayer.removeObserver(self, forKeyPath: "readyForDisplay")
//
//        if self.playerLayer.superlayer == nil {
//            self.view.layer.addSublayer(self.playerLayer)
//        }
//    }

    func setupRangeSlider() {

        rangeSliderConstraintHeight.constant = thumbnailImageViewWidth
        rangeSliderConstraintWidth.constant = thumbnailImageViewWidth * 12

        self.rangeSlider.curvaceousness = 0
        self.rangeSlider.backgroundColor = UIColor.clearColor()
        self.rangeSlider.trackTintColor = UIColor.clearColor()
        self.rangeSlider.thumbTintColor = UIColor(red: 0.902, green: 0.902, blue: 0.902, alpha: 1.0)
        self.rangeSlider.trackHighlightTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)

        self.rangeSlider.lowerValue = 0
        self.rangeSlider.upperValue = 1

        let totalDurationSeconds = CMTimeGetSeconds(self.totalDuration)
        self.startTimeLabel.text = self.secondsToFormatTime(rangeSlider.lowerValue * totalDurationSeconds)
        self.endTimeLabel.text = self.secondsToFormatTime(rangeSlider.upperValue * totalDurationSeconds)
        self.durationTimeLabel.text = self.secondsToFormatTime(rangeSlider.upperValue - rangeSlider.lowerValue)

        rangeSlider.addTarget(self, action: #selector(ViewController.rangeSliderValueChanged(_:)), forControlEvents: .ValueChanged)

        self.getImagesInVideoByURLAndSetToRangeSlider(movieUrl)
    }

    func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.clearColor()
    }

    func setupToolbar() {
    }

    // MARK: - collectionView delegate

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videoUrlArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EditVideoCell", forIndexPath: indexPath) as! EditVideoCell

        if let image = self.getCoverImageInVideoByURL(self.videoUrlArray[indexPath.row]) {
            cell.backgroundView = UIImageView(image: image)
        }

        return cell
    }

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    }

    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

// MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {

        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as? String
        if mediaType == (kUTTypeMovie as String) {

            if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
                self.videoUrlArray.append(url)
                self.movieUrl = url
            }
        }

        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

// MARK: - tool bar

    @IBAction func cameraButtonClick(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.allowsEditing = false
        imagePicker.videoQuality = .TypeHigh
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func libraryButtonClick(sender: AnyObject) {
        let vc = TZImagePickerController(maxImagesCount: 1, delegate: nil)
        vc.allowPickingVideo = true
        // 如果用户选择了一个视频，下面的handle会被执行
        // 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
        vc.didFinishPickingVideoHandle = { coverImage, asset in

            if (asset is ALAsset) {
                let url = asset.defaultRepresentation().url()
                print("File: \(#file), function: \(#function), line: \(#line) -> url: \(url)")
                self.videoUrlArray.append(url)
                self.movieUrl = url
            }

            if #available(iOS 8.0, *) {
                if asset is PHAsset {
                    let options: PHVideoRequestOptions = PHVideoRequestOptions()
                    options.version = .Original
                    PHImageManager.defaultManager().requestAVAssetForVideo((asset as! PHAsset), options: options, resultHandler: { (asset: AVAsset?, audioMix: AVAudioMix?, info: [NSObject: AnyObject]?) -> Void in

                        if let urlAsset = asset as? AVURLAsset {
                            let localVideoUrl: NSURL = urlAsset.URL
                            print("File: \(#file), function: \(#function), line: \(#line) -> url: \(localVideoUrl)")
                            self.videoUrlArray.append(localVideoUrl)
                            self.movieUrl = localVideoUrl
                        } else {
                            print("File: \(#file), function: \(#function), line: \(#line) -> error!!!")
                        }
                    })
                }
            } else {
                // Fallback on earlier versions
            }
            print(coverImage, asset)
        }
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func splitButtonClick(sender: AnyObject) {
    }
    @IBAction func trimButtonClick(sender: AnyObject) {
    }
    @IBAction func nextStepButtonClick(sender: AnyObject) {
    }

// MARK: - swip gestrue change start or end time

// MARK: - images toolbar delegate
// changle start time

// changle end time

// MARK: - select toolbar delegate
// Add sub video

    @IBAction func doneButtonClick(sender: AnyObject) {
        // Playing Multiple Items
        // https://developer.apple.com/library/ios/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW4
    }

    func trimming() {

        let compatiblePresets = AVAssetExportSession.exportPresetsCompatibleWithAsset(asset)
        if compatiblePresets.contains(AVAssetExportPresetLowQuality) {
            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetLowQuality)
            // Implementation continues.
            exportSession?.outputURL = NSURL(fileURLWithPath: NSHomeDirectory().stringByAppendingString("Documents/output.mov"))

            exportSession?.outputFileType = AVFileTypeQuickTimeMovie

            let start = CMTimeMakeWithSeconds(1.0, 600)
            let duration = CMTimeMakeWithSeconds(3.0, 600)
            let range = CMTimeRange(start: start, duration: duration)
            exportSession?.timeRange = range

            exportSession?.exportAsynchronouslyWithCompletionHandler({
                let status: AVAssetExportSessionStatus = (exportSession?.status)!
                switch (status) {
                case .Failed:
                    print("File: \(#file), function: \(#function), line: \(#line) -> ")
                    print(exportSession?.error?.localizedDescription)
                case .Cancelled:
                    print("\(#line) export canneled")
                case .Completed:
                    print("\(#line) export comleted")
                case .Exporting:
                    print("\(#line) Exporting")
                default:
                    break
                }
            })
        }
    }

// Add sub video & done
// retangle or crop to square
// rotation

// MARK: - reponse methods
// play or pause action
    @IBAction func playButton(sender: AnyObject!) {

        let rate = self.player.rate
        if rate < 0.01 {
            self.player.rate = 1
        } else {
            self.player.rate = 0
        }
    }

    @IBAction func restartButton(sender: AnyObject!) {
        let item = self.player.currentItem! //
        item.seekToTime(CMTimeMake(0, 1))
    }

    @IBAction func seekTo5(sender: AnyObject) {
        let time = CMTime(value: 5, timescale: 1)
        print("File: \(#file), function: \(#function), line: \(#line) -> ")
        print(time)
        let item = self.player.currentItem!
        item.seekToTime(time)
    }

    @IBAction func seekTo10(sender: AnyObject) {
        let time = CMTime(seconds: 10, preferredTimescale: 600)
        print("File: \(#file), function: \(#function), line: \(#line) -> ")
        print(time)
        self.player.seekToTime(time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero) { (flag) in
            print(flag)
        }
    }

    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")

        let totalDurationSeconds = CMTimeGetSeconds(self.totalDuration)

        selectedStartTime = CMTime(seconds:
                self.rangeSlider.lowerValue * totalDurationSeconds, preferredTimescale: 600)
        selectedEndTime = CMTime(seconds:
                self.rangeSlider.upperValue * totalDurationSeconds, preferredTimescale: 600)
        selectedDuration = CMTime(seconds:
                ((rangeSlider.upperValue - rangeSlider.lowerValue) * totalDurationSeconds), preferredTimescale: 600)

        self.startTimeLabel.text = self.secondsToFormatTime(rangeSlider.lowerValue * totalDurationSeconds)
        self.endTimeLabel.text = self.secondsToFormatTime(rangeSlider.upperValue * totalDurationSeconds)
        self.durationTimeLabel.text = self.secondsToFormatTime((rangeSlider.upperValue - rangeSlider.lowerValue) * totalDurationSeconds)

        // use seekToTime change display video current frame
        // click paly button change duration

        if previousLowerValue != rangeSlider.lowerValue {

            self.player.seekToTime(selectedStartTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }
        if previousUpperValue != rangeSlider.upperValue {

            self.player.seekToTime(selectedEndTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }

        previousLowerValue = rangeSlider.lowerValue
        previousUpperValue = rangeSlider.upperValue
    }

// MARK: - private methods
    func secondsToFormatTime(seconds: Double) -> String {

        return NSString(format: "%0.f:%0.1f",
            seconds / 60,
            seconds % 60) as String
    }

    func getCoverImageInVideoByURL(url: NSURL) -> UIImage? {

        let asset = AVAsset(URL: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        if let cfImage = try? imageGenerator.copyCGImageAtTime(kCMTimeZero, actualTime: nil) {
            let image = UIImage(CGImage: cfImage)
            return image
        } else {
            return nil
        }
    }

    func getImagesInVideoByURLAndSetToRangeSlider(url: NSURL) {

        // create an asset object

        let options = [AVURLAssetPreferPreciseDurationAndTimingKey: true]
        let asset = AVURLAsset(URL: url, options: options)

        let totalDurationSeconds = CMTimeGetSeconds(asset.duration)
        self.startTimeLabel.text = self.secondsToFormatTime(rangeSlider.lowerValue * totalDurationSeconds)
        self.endTimeLabel.text = self.secondsToFormatTime(rangeSlider.upperValue * totalDurationSeconds)
        self.durationTimeLabel.text = self.secondsToFormatTime(rangeSlider.upperValue - rangeSlider.lowerValue)

        self.rangeSlider.lowerValue = 0
        self.rangeSlider.upperValue = 1
//        let keys = ["duration"]
//        asset.loadValuesAsynchronouslyForKeys(keys) {
//
//            var error: NSError? = nil
//            let tracksStatus = self.asset.statusOfValueForKey("duration", error: &error)
//            switch (tracksStatus) {
//            case AVKeyValueStatus.Loaded:
//                print("\(#line)updateUserInterfaceForDuration")
//                self.totalDuration = self.asset.duration
//            case .Failed:
//                print("Line \(#line) ->")
//                print(error?.localizedDescription)
//            case .Cancelled:
//                print("\(#line)Cancelled")
//            default:
//                break
//            }
//        }
        // getting s sequence of images

        // Assume: @property (strong) AVAssetImageGenerator *imageGenerator;
        self.imageGenerator = AVAssetImageGenerator(asset: asset)

        var times = [NSValue]()
        for i in 0 ... 10 {
            let seconds = CMTimeGetSeconds(asset.duration)
            let time = CMTime(seconds: seconds * Double(i) / 10.0, preferredTimescale: 600)
            times.append(NSValue(CMTime: time))
        }

        self.rangeSliderImageArray = [UIImage]()
        self.imageGenerator.generateCGImagesAsynchronouslyForTimes(times) { (requestedTime, image, actualTime, result, error) in

            switch (result) {
            case AVAssetImageGeneratorResult.Succeeded:

                self.rangeSliderImageArray.append(UIImage(CGImage: image!))
                var previousImageView: UIImageView? = nil
                if self.rangeSliderImageArray.count > 10 {
                    if self.isFirstTimeAddImageToRangeSlider == true {

                        self.isFirstTimeAddImageToRangeSlider = false

                        dispatch_async(dispatch_get_main_queue(), {

                            for i in 0 ... 10 {

                                let imageView = UIImageView()
                                imageView.tag = i

                                imageView.image = self.rangeSliderImageArray[i]
                                imageView.contentMode = .ScaleAspectFill
                                imageView.clipsToBounds = true
                                self.imageViewsContainer.addSubview(imageView)
                                imageView.translatesAutoresizingMaskIntoConstraints = false

                                self.imageViewsContainer.addConstraints([
                                    NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v(h)]-0-|", options: [], metrics: ["h": self.thumbnailImageViewWidth], views: ["v": imageView])
                                    ].flatten().map { $0 })

                                if previousImageView == nil { // first one, pin to top
                                    self.imageViewsContainer.addConstraints([
                                        NSLayoutConstraint.constraintsWithVisualFormat("H:|-p-[v(w)]", options: [], metrics: ["p": (self.thumbnailImageViewWidth / 2), "w": self.thumbnailImageViewWidth], views: ["v": imageView])
                                        ].flatten().map { $0 })
                                } else { // all others, pin to previous
                                    self.imageViewsContainer.addConstraints([
                                        NSLayoutConstraint.constraintsWithVisualFormat(
                                            "H:[pv]-0-[v(w)]", options: [], metrics: ["w": self.thumbnailImageViewWidth], views: ["pv": previousImageView!, "v": imageView])
                                        ].flatten().map { $0 })
                                }
                                previousImageView = imageView
                            }
                        })
                    } else {

                        dispatch_async(dispatch_get_main_queue(), {

                            for i in 0 ... 10 {
                                for v in self.imageViewsContainer.subviews {
                                    if v is UIImageView && v.tag == i {
                                        (v as! UIImageView).image = self.rangeSliderImageArray[i]
                                    }
                                }
                            }

                            self.imageViewsContainer.setNeedsDisplay()
                        })
                    }
                }

            case AVAssetImageGeneratorResult.Failed:
                print("Line \(#line) ->")
                print(error?.localizedDescription)
            case AVAssetImageGeneratorResult.Cancelled:
                print("\(#line) canceled")
            }
        }
    }

// change playing video range
    func changePlayingVideoByURL(url: NSURL) {

        self.player.pause()

        let asset = AVURLAsset(URL: url, options: nil)
        self.totalDuration = asset.duration
        let composion = AVMutableComposition()
        let range = CMTimeRange(start: kCMTimeZero, duration: asset.duration)
        _ = try? composion.insertTimeRange(range, ofAsset: asset, atTime: kCMTimeZero)
        let item = AVPlayerItem(asset: composion)
        self.player.replaceCurrentItemWithPlayerItem(item)

        self.player.play()
    }
}
