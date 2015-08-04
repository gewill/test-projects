//
//  AppDelegate.swift
//  testReveal
//
//  Created by Will Ge on 8/3/15.
//  Copyright (c) 2015 gewill.org. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        self.loadReveal()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // MARK: - Reveal
    
    func loadReveal() {
        if NSClassFromString("IBARevealLoader") == nil {
            let revealLibName = "libReveal"
            let revealLibExtension = "dylib"
            var error: String?
            if let dylibPath = NSBundle.mainBundle().pathForResource(revealLibName, ofType: revealLibExtension) {
                println("Loading dynamic library \(dylibPath)")
                let revealLib = dlopen(dylibPath, RTLD_NOW)
                if revealLib == nil {
                    error = String(UTF8String: dlerror())
                }
            } else {
                error = "File not found."
            }
            
            if error != nil {
                UIAlertView(
                    title: "Reveal library could not be loaded",
                    message: "\(revealLibName).\(revealLibExtension) failed to load with error: \(error!)",
                    delegate: nil,
                    cancelButtonTitle: "OK"
                    ).show()
            }
        }
    }

}

