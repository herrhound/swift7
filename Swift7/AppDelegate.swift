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
    var wrapper: KeychainWrapper!
    var signIn: GPPSignIn!
    var kClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    
    //var dal = RegistrationDAL()
    

    func appDidFinishLaunching(application: UIApplication)
    {
        let a = true
        #if DEBUG
            println("DEBUG")
        #endif
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        wrapper = KeychainWrapper()
        let viewController : ViewController = self.window?.rootViewController as ViewController
        viewController.keychain = self.wrapper

//        var gc = GoogleCredentials()
//        gc.credentialId = 1
//        gc.kClientId = "ClientId"
//        gc.kServerClientId = "ServerClientId"
//        gc.kSecret = "Secret"
//        
//        if wrapper.ObjectForKey(kSecValuePersistentRef as AnyObject) == nil
//        {
//            wrapper.SetObject(gc, forKey: kSecValuePersistentRef)
//        }
//        
        signIn = GPPSignIn.sharedInstance()
        signIn.clientID = kClientId
        viewController.signIn = self.signIn
        
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
        println("applicationWillTerminate")
    }

}

