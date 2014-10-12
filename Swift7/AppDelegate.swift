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
    var googleCredentials: GoogleCredentials!
    //var kClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    
    //var dal = RegistrationDAL()
    
    func getGoogleCredentials()
    {
        //spinner.startAnimating()

        let URLWithString = NSString(format: "https://dry-atoll-6423.herokuapp.com/provisionOAuth2IDs")
        let url: NSURL = NSURL(string: URLWithString)
        var request = NSMutableURLRequest(URL:url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        request.HTTPMethod = "GET"
        
        var data: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error)!
            
            if error == nil
            {
                var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                self.googleCredentials = GoogleCredentials(data: jsonResult)
            }
            else{
                //spinner.stopAnimating()
                println(NSString(format: "Error from getGoogleCredentials: @%", error.debugDescription))
            }
        
    
    }

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

        getGoogleCredentials()

        signIn = GPPSignIn.sharedInstance()
        signIn.clientID = self.googleCredentials.kClientId
        viewController.signIn = self.signIn
        viewController.googleCredentials = self.googleCredentials
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
        let baseController : BaseViewController = self.window?.rootViewController as BaseViewController
        baseController.hasInternetConnection =  baseController.isConnectedToNetwork()
    }

    func applicationWillTerminate(application: UIApplication) {
        println("applicationWillTerminate")
    }

}

