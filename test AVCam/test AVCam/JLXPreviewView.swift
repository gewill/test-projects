//
//  JLXPreviewView.swift
//  test AVCam
//
//  Created by Will on 4/15/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit
import AVFoundation

class JLXPreviewView: UIView {
//	dynamic var session: AVCaptureSession! {
//		get {
//			return (self.layer as! AVCaptureVideoPreviewLayer).session
//		}
//		set {
//			(self.layer as! AVCaptureVideoPreviewLayer).session = newValue
//		}
//	}
//
//	override class func layerClass() -> AnyClass {
//		return AVCaptureVideoPreviewLayer.self
//	}

	override class func layerClass() -> AnyClass {
		return AVCaptureVideoPreviewLayer.self
	}

	func session() -> AVCaptureSession {
		return (self.layer as! AVCaptureVideoPreviewLayer).session
	}

	func setSession(session: AVCaptureSession) -> Void {
		(self.layer as! AVCaptureVideoPreviewLayer).session = session;
		(self.layer as! AVCaptureVideoPreviewLayer).videoGravity = AVLayerVideoGravityResizeAspect;
	}
}
