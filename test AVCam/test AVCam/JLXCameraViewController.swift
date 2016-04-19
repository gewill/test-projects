//
//  JLXCameraViewController.swift
//  test AVCam
//
//  Created by Will on 4/15/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Photos
import AssetsLibrary

enum JLXAVCamSetupResult {
    case Success
    case CameraNotAuthorized
    case SessionConfiguratonFailed
}

private var SessionRunningContext = 0

class JLXCameraViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    @IBOutlet var previewView: JLXPreviewView!

    @IBOutlet var cameraUnavailableLabel: UILabel!
    @IBOutlet var resumeButton: UIButton!

    @IBOutlet var flashButton: UIButton!
    @IBOutlet var changeCameraButton: UIButton!
    @IBOutlet var cancelButton: UIButton!

    @IBOutlet var durationLabel: UILabel!

    @IBOutlet var recordButton: UIButton!

    // Session management

    // Communicate with the session and other session objects on this queue.
    var sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL)
    dynamic var session: AVCaptureSession!
    var videoDeviceInput: AVCaptureDeviceInput!
    var movieFileOutput: AVCaptureMovieFileOutput!

    // Utilities
    var setupResult: JLXAVCamSetupResult!
    var sessionRunning: Bool!
    var backgroundRecordingId: UIBackgroundTaskIdentifier!
    var durationTimer: NSTimer?
    var seconds: Int!
    var isRecording = false

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()

        self.setupSession()
    }

    func setupUI() {
        // Disable UI. The UI is enabled if and only if the session starts running.
        self.changeCameraButton.enabled = false
        self.recordButton.enabled = false
        self.flashButton.enabled = false

        self.resumeButton.setTitle("Tap to resume", forState: .Normal)
        self.resumeButton.hidden = true
        self.cameraUnavailableLabel.text = "Camera Unavailable"
        self.cameraUnavailableLabel.hidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(JLXCameraViewController.focusAndExposeTap(_:)))
        self.previewView.addGestureRecognizer(tapGesture)
    }

    func setupAuthorization() {
        // Check video authorization status. Video access is required and audio access is optional.
        // If audio access is denied, audio is not recorded during movie recording.

        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case AVAuthorizationStatus.NotDetermined:
            dispatch_suspend(self.sessionQueue)
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: {
                (granted) in
                if granted == false {
                    self.setupResult = JLXAVCamSetupResult.CameraNotAuthorized
                }
                dispatch_resume(self.sessionQueue)
            })
        case AVAuthorizationStatus.Authorized:
            self.setupResult = JLXAVCamSetupResult.Success
        default:
            self.setupResult = JLXAVCamSetupResult.CameraNotAuthorized
        }
    }

    // Setup the capture session.
    // In general it is not safe to mutate an AVCaptureSession or any of its inputs, outputs, or connections from multiple threads at the same time.
    // Why not do all of this on the main queue?
    // Because -[AVCaptureSession startRunning] is a blocking call which can take a long time. We dispatch session setup to the sessionQueue
    // so that the main queue isn't blocked, which keeps the UI responsive.
    func setupSession() {
        // Create the AVCaptureSession.
        self.session = AVCaptureSession()

        // Setup the preview view.
        self.previewView.setSession(self.session)

        self.setupResult = JLXAVCamSetupResult.Success

        self.setupAuthorization()

        dispatch_async(self.sessionQueue) {
            if self.setupResult != JLXAVCamSetupResult.Success {
                return
            }

            self.backgroundRecordingId = UIBackgroundTaskInvalid

            let videoDevice: AVCaptureDevice = JLXCameraViewController.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)

            var videoDeviceInput: AVCaptureDeviceInput?
            do {
                videoDeviceInput = try AVCaptureDeviceInput.init(device: videoDevice)
            } catch let error as NSError {
                print("Could not create video device input: \(error.debugDescription)")
            }

            self.session.beginConfiguration()

            if self.session.canAddInput(videoDeviceInput) {
                self.session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput

                dispatch_async(dispatch_get_main_queue()) {
                    // Why are we dispatching this to the main queue?
                    // Because AVCaptureVideoPreviewLayer is the backing layer for AAPLPreviewView and UIView
                    // can only be manipulated on the main thread.
                    // Note: As an exception to the above rule, it is not necessary to serialize video orientation changes
                    // on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.

                    // Use the status bar orientation as the initial video orientation. Subsequent orientation changes are handled by
                    // -[viewWillTransitionToSize:withTransitionCoordinator:].
                    let orientation = AVCaptureVideoOrientation.LandscapeRight
                    let previewLayer = self.previewView.layer as! AVCaptureVideoPreviewLayer
                    previewLayer.connection.videoOrientation = orientation
                }
            } else {
                print("Could not add video device input to the session")
                self.setupResult = JLXAVCamSetupResult.SessionConfiguratonFailed
            }

            // TODO: - test failed
            let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
            let audioDeviceInput: AVCaptureDeviceInput?
            do {
                audioDeviceInput = try AVCaptureDeviceInput.init(device: audioDevice)
            } catch let error as NSError {
                print("Could not create audio device input: \(error.debugDescription.debugDescription)")
            }

            let movieFileOutput = AVCaptureMovieFileOutput()
            if self.session.canAddOutput(movieFileOutput) {
                self.session.addOutput(movieFileOutput)
                let connection = movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
                if #available(iOS 8.0, *) {
                    if connection.supportsVideoStabilization {
                        connection.preferredVideoStabilizationMode = .Auto
                    }
                } else {
                    connection.enablesVideoStabilizationWhenAvailable = true
                }

                if connection.supportsVideoOrientation {
                    connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
                }

                self.movieFileOutput = movieFileOutput
            } else {
                print("Could not add movie file output to the session")
                self.setupResult = JLXAVCamSetupResult.SessionConfiguratonFailed
            }

            self.session.commitConfiguration()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // response setupResult

        dispatch_async(self.sessionQueue) {
            if let result = self.setupResult {
                switch result {
                case .Success:
                    // Only setup observers and start the session running if setup succeeded.
                    self.addObservers()
                    self.session.startRunning()
                    self.sessionRunning = self.session.running
                case .CameraNotAuthorized:
                    dispatch_async(dispatch_get_main_queue()) {
                        let title = NSBundle.mainBundle().localizedInfoDictionary!["CFBundleName"] as! String
                        let message = String.localizedStringWithFormat("AVCam doesn't have permission to use the camera, please change privacy settings", "Alert message when the user has denied access to the camera")
                        let cancelText = String.localizedStringWithFormat("OK", "Alert OK button")
                        let settingsText = String.localizedStringWithFormat("Settings", "Alert button to open Settings")
                        if #available(iOS 8.0, *) {
                            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                            let cancelAction = UIAlertAction(title: cancelText, style: UIAlertActionStyle.Cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            let settingsAction = UIAlertAction(title: settingsText, style: UIAlertActionStyle.Default, handler: {
                                (action) in
                                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                            })
                            alertController.addAction(settingsAction)
                            self.presentViewController(alertController, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelText, otherButtonTitles: settingsText)
                            alert.show()
                        }
                    }
                case .SessionConfiguratonFailed:
                    let title = NSBundle.mainBundle().localizedInfoDictionary!["CFBundleName"] as! String
                    let message = String.localizedStringWithFormat("Unable to capture media", "Alert message when something goes wrong during capture session configuration")
                    let cancelText = String.localizedStringWithFormat("OK", "Alert OK button")
                    if #available(iOS 8.0, *) {
                        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelAction = UIAlertAction(title: cancelText, style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelText)
                        alert.show()
                    }
                }
            }
        }
    }

    override func viewDidDisappear(animated: Bool) {
        dispatch_async(self.sessionQueue) {
            if self.setupResult == JLXAVCamSetupResult.Success {
                self.session.stopRunning()
                self.removeObservers()
            }
        }

        super.viewDidDisappear(animated)
    }

    // MARK: - Orientation

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.LandscapeRight
    }

    // MARK: - KVO and Notifications

    func addObservers() {
        self.session.addObserver(self, forKeyPath: "running", options: NSKeyValueObservingOptions.New, context: &SessionRunningContext)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(subjectAreaDidChange(_:)), name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput.device)
        // A session can only run when the app is full screen. It will be interrupted
        // in a multi-app layout, introduced in iOS 9,
        // see also the documentation of AVCaptureSessionInterruptionReason. Add
        // observers to handle these session interruptions
        // and show a preview is paused message. See the documentation of
        // AVCaptureSessionWasInterruptedNotification for other
        // interruption reasons.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(sessionWatInterruptedEnded(_:)), name: AVCaptureSessionWasInterruptedNotification, object: self.session)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(sessionWatInterruptedEnded(_:)), name: AVCaptureSessionInterruptionEndedNotification, object: self.session)
    }

    func removeObservers() {
        self.session.removeObserver(self, forKeyPath: "running", context: &SessionRunningContext)

        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String:AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &SessionRunningContext {
            if let isSessionRunning = change?[NSKeyValueChangeNewKey]?.boolValue where
            isSessionRunning == true {
                dispatch_async(dispatch_get_main_queue()) {
                    // Only enable the ability to change camera if the device has more than
                    // one camera.
                    self.changeCameraButton.enabled = isSessionRunning && (AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count > 1)
                    self.recordButton.enabled = isSessionRunning
                }
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

    func subjectAreaDidChange(notification: NSNotification) {
        let devicePoiont = CGPoint(x: 0.5, y: 0.5)
        self.focusWithMode(AVCaptureFocusMode.ContinuousAutoFocus, exposureWithMode: AVCaptureExposureMode.ContinuousAutoExposure, atDevicePoint: devicePoiont, monitorSubjectAreaChange: false)
    }

    func sessionRuntimeError(notification: NSNotification) {
        // Automatically try to restart the session running if media services were
        // reset and the last start running succeeded.
        // Otherwise, enable the user to try to resume the session running.
        if let error = notification.userInfo?[AVCaptureSessionErrorKey] where
        error.code == AVError.MediaServicesWereReset.rawValue {
            dispatch_async(self.sessionQueue, {
                if self.sessionRunning == true {
                    self.session.startRunning()
                    self.sessionRunning = self.session.running
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.resumeButton.hidden = false
                    })
                }
            })
        } else {
            self.resumeButton.hidden = false
        }
    }

    func sessionWasInterrupted(notification: NSNotification) {
        // In some scenarios we want to enable the user to resume the session running.
        // For example, if music playback is initiated via control center while using AVCam,
        // then the user can let AVCam resume the session running, which will stop music playback.
        // Note that stopping music playback in control center will not automatically resume the session running.
        // Also note that it is not always possible to resume, see -[resumeInterruptedSession:].

        var showResumeButton = false

        // In iOS 9 and later, the userInfo dictionary contains information on why the
        // session was interrupted.
        if #available(iOS 9.0, *) {
            if let reason = notification.userInfo?[AVCaptureSessionInterruptionReasonKey] where reason is Int {
                if (reason as! Int) == AVCaptureSessionInterruptionReason.AudioDeviceInUseByAnotherClient.rawValue || (reason as! Int) == AVCaptureSessionInterruptionReason.VideoDeviceInUseByAnotherClient.rawValue {
                    showResumeButton = true
                } else if (reason as! Int) == AVCaptureSessionInterruptionReason.VideoDeviceNotAvailableWithMultipleForegroundApps.rawValue {
                    // Simply fade-in a label to inform the user that the camera is
                    // unavailable.
                    self.cameraUnavailableLabel.hidden = false
                    self.cameraUnavailableLabel.alpha = 0
                    UIView.animateWithDuration(0.25, animations: {
                        self.cameraUnavailableLabel.alpha = 1
                    })
                }
            }
        } else {
            print("Capture session was interrupted")
            showResumeButton = UIApplication.sharedApplication().applicationState == UIApplicationState.Inactive
        }

        if showResumeButton {
            // Simply fade-in a button to enable the user to try to resume the session
            // running.
            self.resumeButton.hidden = false
            self.resumeButton.alpha = 0
            UIView.animateWithDuration(0.25, animations: {
                self.resumeButton.alpha = 1
            })
        }
    }

    func sessionWatInterruptedEnded(notification: NSNotification) {
        print("Capture session interruption ended")

        // hide buttons with animations
        if !self.resumeButton.hidden {
            UIView.animateWithDuration(0.25, animations: {
                self.resumeButton.alpha = 0
            }, completion: {
                (finished) in
                self.resumeButton.hidden = true
            })
        }

        if !self.cameraUnavailableLabel.hidden {
            UIView.animateWithDuration(0.25, animations: {
                self.cameraUnavailableLabel.alpha = 0
            }, completion: {
                (finished) in
                self.cameraUnavailableLabel.hidden = true
            })
        }
    }

    // MARK: -  Response Actions

    @IBAction func resumeButtonClick(sender: AnyObject) {
        dispatch_async(self.sessionQueue) {
            // The session might fail to start running, e.g., if a phone or FaceTime
            // call is still using audio or video.
            // A failure to start the session running will be communicated via a session
            // runtime error notification.
            // To avoid repeatedly failing to start the session running, we only try to
            // restart the session running in the
            // session runtime error handler if we aren't trying to resume the session
            // running.
            self.session.startRunning()
            self.durationTimer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(JLXCameraViewController.refreshDurationLabel), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(self.durationTimer!, forMode: NSRunLoopCommonModes)
            self.durationTimer?.fire()

            self.sessionRunning = self.session.running
            if !self.session.running {
                dispatch_async(dispatch_get_main_queue()) {
                    let title = NSBundle.mainBundle().localizedInfoDictionary!["CFBundleName"] as! String
                    let message = String.localizedStringWithFormat("Unable to resume", "Alert message when unable to resume the session running")
                    let cancelText = String.localizedStringWithFormat("OK", "Alert OK button")
                    if #available(iOS 8.0, *) {
                        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        let cancelAction = UIAlertAction(title: cancelText, style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelText)
                        alert.show()
                    }
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.resumeButton.hidden = false
                }
            }
        }
    }

    @IBAction func recordButtonClick(sender: AnyObject) {
        // Disable the Camera button until recording finishes, and disable the Record
        // button until recording starts or finishes. See the
        // AVCaptureFileOutputRecordingDelegate methods.
        self.changeCameraButton.enabled = false
        self.recordButton.enabled = false

        if self.isRecording == true {
            self.durationTimer?.invalidate()
            self.durationTimer = nil
            self.seconds = 0
            self.durationLabel.text = secondsToFormatTimeFull(0)
        } else {
            self.seconds = 0
            self.durationTimer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(JLXCameraViewController.refreshDurationLabel), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(self.durationTimer!, forMode: NSRunLoopCommonModes)
            self.durationTimer?.fire()
        }

        self.isRecording = !isRecording

        dispatch_async(self.sessionQueue) {
            if !self.movieFileOutput.recording && UIDevice.currentDevice().multitaskingSupported {
                // Setup background task. This is needed because the
                // -[captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:]
                // callback is not received until AVCam returns to the foreground unless
                // you request background execution time.
                // This also ensures that there will be time to write the file to the
                // photo library when AVCam is backgrounded.
                // To conclude this background execution, -endBackgroundTask is called
                // in
                // -[captureOutput:didFinishRecordingToOutputFileAtURL:fromConnections:error:]
                // after the recorded file has been saved.
                self.backgroundRecordingId = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler(nil)

                // Turn OFF flash for video recording.
                JLXCameraViewController.setFlashMode(AVCaptureFlashMode.Off, forDevice: self.videoDeviceInput.device)

                // Start recording to a temporary file.
                let outputFileName = NSProcessInfo.processInfo().globallyUniqueString
                let outputFileUrl = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(outputFileName).URLByAppendingPathExtension("mov")
                self.movieFileOutput.startRecordingToOutputFileURL(outputFileUrl, recordingDelegate: self)
            } else {
                self.movieFileOutput.stopRecording()
            }
        }
    }

    @IBAction func changeCameraButtonClick(sender: AnyObject) {
        self.changeCameraButton.enabled = false
        self.recordButton.enabled = false

        dispatch_async(self.sessionQueue) {
            let currentVideoDivice = self.videoDeviceInput.device
            var preferredPosition = AVCaptureDevicePosition.Unspecified
            let currentPosition = currentVideoDivice.position

            switch currentPosition {
            case AVCaptureDevicePosition.Front:
                preferredPosition = AVCaptureDevicePosition.Back
            case AVCaptureDevicePosition.Back:
                preferredPosition = AVCaptureDevicePosition.Front
            default:
                break
            }

            let videoDevice = JLXCameraViewController.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: preferredPosition)

            var videoDeviceInput: AVCaptureDeviceInput?
            do {
                videoDeviceInput = try AVCaptureDeviceInput.init(device: videoDevice)
            } catch let error as NSError {
                print("Could not create video device input: \(error.debugDescription)")
            }

            self.session.beginConfiguration()

            // Remove the existing device input first, since using the front and back
            // camera simultaneously is not supported.
            self.session.removeInput(self.videoDeviceInput)

            if self.session.canAddInput(videoDeviceInput) {
                NSNotificationCenter.defaultCenter().removeObserver(self, name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: currentVideoDivice)

                JLXCameraViewController.setFlashMode(AVCaptureFlashMode.Auto, forDevice: videoDevice)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(JLXCameraViewController.subjectAreaDidChange(_:)), name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: videoDevice)

                self.session.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                self.session.addInput(self.videoDeviceInput)
            }

            let connection = self.movieFileOutput.connectionWithMediaType(AVMediaTypeVideo)
            if connection.supportsVideoStabilization {
                if #available(iOS 8.0, *) {
                    connection.preferredVideoStabilizationMode = .Auto
                } else {
                    connection.enablesVideoStabilizationWhenAvailable = true
                }
            }

            self.session.commitConfiguration()

            dispatch_async(dispatch_get_main_queue()) {
                self.changeCameraButton.enabled = true
                self.recordButton.enabled = true
            }
        }
    }

    func focusAndExposeTap(gestureRecognizer: UIGestureRecognizer) {
        let devicePoint = (self.previewView.layer as! AVCaptureVideoPreviewLayer).captureDevicePointOfInterestForPoint(gestureRecognizer.locationInView(gestureRecognizer.view))
        self.focusWithMode(AVCaptureFocusMode.AutoFocus, exposureWithMode: AVCaptureExposureMode.AutoExpose, atDevicePoint: devicePoint, monitorSubjectAreaChange: true)
    }

    @IBAction func flashButtonClick(sender: AnyObject) {
        // TODO: - should deal while changeCameraButton
    }

    func refreshDurationLabel() {
        seconds = seconds + 1
        self.durationLabel.text = secondsToFormatTimeFull(Double(self.seconds))
    }

    // MARK: - File Output Recording Delegate
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        // Enable the Record button to let the user stop the recording.
        dispatch_async(dispatch_get_main_queue()) {
            self.recordButton.enabled = true
            self.recordButton.setTitle(String.localizedStringWithFormat("Stop", "Recording button stop title"), forState: .Normal)
        }
    }

    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        // Note that currentBackgroundRecordingID is used to end the background task
        // associated with this recording.
        // This allows a new recording to be started, associated with a new
        // UIBackgroundTaskIdentifier, once the movie file output's isRecording
        // property
        // is back to NO — which happens sometime after this method returns.
        // Note: Since we use a unique file path for each recording, a new recording
        // will not overwrite a recording currently being saved.
        let currentBackgroundRecordingId = self.backgroundRecordingId
        self.backgroundRecordingId = UIBackgroundTaskInvalid

        var success = true
        let cleanup: dispatch_block_t = {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(outputFileURL)
            } catch let error as NSError {
                // lower version than iOS 9
                if UIDevice.currentDevice().systemVersion.compare("9.0.0", options: NSStringCompareOptions.NumericSearch) == .OrderedAscending {
                    print(" \(error.debugDescription)")
                }
                success = false
            }

            if currentBackgroundRecordingId != UIBackgroundTaskInvalid {
                UIApplication.sharedApplication().endBackgroundTask(currentBackgroundRecordingId)
            }
        }

        if success {
            // Check authorization status.
            if #available(iOS 8.0, *) {
                PHPhotoLibrary.requestAuthorization({
                    (status) in
                    if status == PHAuthorizationStatus.Authorized {
                        // Save the movie file to the photo library and cleanup.
                        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                            // In iOS 9 and later, it's possible to move the file into the photo
                            // library without duplicating the file data.
                            // This avoids using double the disk space during save, which can make
                            // a difference on devices with limited free disk space.
                            if #available(iOS 9.0, *) {
                                let options = PHAssetResourceCreationOptions()
                                options.shouldMoveFile = true
                                let changeRequest = PHAssetCreationRequest.creationRequestForAsset()
                                changeRequest.addResourceWithType(PHAssetResourceType.Video, fileURL: outputFileURL, options: options)
                            } else {
                                // Fallback on iOS 8 versions
                                PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(outputFileURL)
                            }
                        }, completionHandler: {
                            (success, error) in
                            if !success {
                                print("Could not save movie to photo library: \(error.debugDescription)")
                            }
                            cleanup()
                        })
                    } else {
                        cleanup()
                    }
                })
            } else {
                // Fallback on iOS 7 versions
                let library: ALAssetsLibrary = ALAssetsLibrary()
                if library.videoAtPathIsCompatibleWithSavedPhotosAlbum(outputFileURL) {
                    library.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: {
                        (newURL: NSURL!, error: NSError!) in
                        if (error != nil) {
                            print("Error writing image with metadata to Photo Library: \(error.debugDescription)")
                        }
                        cleanup()
                    })
                }
            }
        } else {
            cleanup()
        }

        // Enable the Camera and Record buttons to let the user switch camera and
        // start another recording.
        dispatch_async(dispatch_get_main_queue()) {
            // Only enable the ability to change camera if the device has more than one
            // camera.
            self.changeCameraButton.enabled = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo).count > 1
            self.recordButton.enabled = true
            self.recordButton.setTitle(String.localizedStringWithFormat("Record", "Recording button record title"), forState: .Normal)
        }
    }

    // MARK: - Device Configuration
    func focusWithMode(focusMode: AVCaptureFocusMode, exposureWithMode exposureMode: AVCaptureExposureMode, atDevicePoint point: CGPoint, monitorSubjectAreaChange: Bool) {
        dispatch_async(self.sessionQueue) {
            let device = self.videoDeviceInput.device
            do {
                try device.lockForConfiguration()
                // Setting (focus/exposure)PointOfInterest alone does not initiate a
                // (focus/exposure) operation.
                // Call -set(Focus/Exposure)Mode: to apply the new point of interest.
                if device.focusPointOfInterestSupported && device.isFocusModeSupported(AVCaptureFocusMode.AutoFocus) {
                    device.focusPointOfInterest = point
                    device.focusMode = focusMode
                }

                if device.exposurePointOfInterestSupported && device.isExposureModeSupported(AVCaptureExposureMode.AutoExpose) {
                    device.exposurePointOfInterest = point
                    device.exposureMode = exposureMode
                }

                device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange

                device.unlockForConfiguration()
            } catch let error as NSError {
                print(" \(error.debugDescription)")
            }
        }
    }

    class func setFlashMode(flashMode: AVCaptureFlashMode, forDevice device: AVCaptureDevice) {
        if device.hasFlash && device.isFlashModeSupported(flashMode) {
            do {
                try device.lockForConfiguration()
                device.flashMode = flashMode
                device.unlockForConfiguration()
            } catch let error as NSError {
                print("Could not lock device for configuration: \(error.debugDescription)")
            }
        }
    }

    class func deviceWithMediaType(mediaType: String, preferringPosition position: AVCaptureDevicePosition) -> AVCaptureDevice {
        let devices = AVCaptureDevice.devicesWithMediaType(mediaType) as! [AVCaptureDevice!]
        var captureDevice = devices.first

        for device in devices {
            if device.position == position {
                captureDevice = device
                break
            }
        }

        return captureDevice!
    }
}
