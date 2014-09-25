//
//  AppDelegate.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    //var dal = RegistrationDAL()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: NSString,
        annotation: AnyObject?) -> Bool{
        return GPPURLHandler.handleURL(url, sourceApplication:sourceApplication, annotation:annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

}

