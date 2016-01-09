//
//  AppDelegate.swift
//  test UIWindow
//
//  Created by Will on 1/9/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var window2: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        self.window!.rootViewController = ViewController()
        self.window!.backgroundColor = UIColor ( red: 0.0, green: 1.0, blue: 0.502, alpha: 1.0 )
        self.window!.makeKeyAndVisible()
        
        self.window2 = UIWindow(frame: CGRectMake(0, UIScreen.mainScreen().bounds.height - 200, UIScreen.mainScreen().bounds.width - 8, 300))
        self.window2!.rootViewController = ViewController2()
        self.window2!.backgroundColor = UIColor ( red: 0.3383, green: 1.0, blue: 1.0, alpha: 1.0 )
        self.window2!.makeKeyAndVisible()
        
        return true
    }



}

