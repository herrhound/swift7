//
//  ViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit
import Security

//class GPPSignInButton

class ViewController: UIViewController, GPPSignInDelegate {    
    //var signIn: GPPSignIn
    //var kClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    var kServerClientId: NSString = "783241267105-bc7pq09tr1nnogat72r9tgmaeg2mre28.apps.googleusercontent.com"
    var kSecret: NSString = "MbSGiXXwLPaanFbJSVseW9qs"
    var responsData: NSMutableData = NSMutableData()
    var credentials: GTMOAuth2Authentication! = nil
    var signIn: GPPSignIn! // = GPPSignIn.sharedInstance()
    var keychain: KeychainWrapper!
    var spinner: UIActivityIndicatorView!

    
    @IBOutlet var lblInfo: UILabel!
    @IBOutlet var signInButton: GPPSignInButton!
    @IBOutlet var btnGoogleAuthDisconect: UIButton!
    
    func initSpinner()
    {
        let screenRect = UIScreen.mainScreen().bounds
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.spinner.center = CGPoint(x: screenRect.width / 2.0, y: screenRect.height / 2.0)
        self.view.addSubview(self.spinner)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func disconect() -> Void {
        self.signIn.disconnect()
    }
    
    @IBAction func btnGoogleAuthDisconect_TouchUpInside(sender: AnyObject) {
        self.disconect()
        //self.signIn.authenticate()
    }
    
    func presentSignInViewController(viewController: UIViewController){
        navigationController?.pushViewController(self, animated:true)
    }

    func doRequestCallback(let code: NSString) {
        self.lblInfo.hidden = true
        self.signInButton.hidden = true
        self.spinner.startAnimating()
        
        let URLWithString = NSString(format:"https://dry-atoll-6423.herokuapp.com/oauth2callback?code=%@", code)
        let url: NSURL = NSURL(string: URLWithString)
        var request = NSMutableURLRequest(URL:url)

        request.HTTPMethod = "GET"

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: {(response, data, error) -> Void in
            
            if error == nil
            {
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
                let googleToken = GoogleToken(access_token: jsonResult.valueForKey("access_token") as String, expires_in: jsonResult.valueForKey("expires_in") as Int, id_token: jsonResult.valueForKey("id_token") as String, refresh_token: jsonResult.valueForKey("refresh_token") as String, token_type: jsonResult.valueForKey("token_type")as String)
                println(googleToken)
            
                self.keychain.SetObject(googleToken.access_token, forKey: kSecValueData)
                self.lblInfo.hidden = true
                self.signInButton.hidden = true
                self.performSegueWithIdentifier("MainViewSegue", sender: self)
            }
            else{
                self.lblInfo.hidden = false
                self.signInButton.hidden = false
                self.spinner.stopAnimating()
            }
        })

        self.spinner.stopAnimating()
    }
    
    func doRegisterUser(let access_token: NSString) {
        
        var err: NSError?
        let URLWithString = NSString(format:"https://dry-atoll-6423.herokuapp.com/registeruser?access_token=%@", access_token)
        let url: NSURL = NSURL(string: URLWithString)
        var request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: {(response, data, err) -> Void in
                var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let googleUserInfo = GoogleUserInfo(data:result)
            println(googleUserInfo)
        })
    }

    
    func finishedWithAuth(auth: GTMOAuth2Authentication, error: NSError!) ->Void{
        if(error != nil)
        {
            println("Hello!")
            println("Received error %@ ", error)
        }
        else
        {
            if(self.signIn.homeServerAuthorizationCode != nil){
                let serverCode: NSString = self.signIn.homeServerAuthorizationCode;
                self.doRequestCallback(serverCode as NSString)
            }
        }
    }
    
    
//    @IBAction func btnAcn(sender : AnyObject) {
//        self.performSegueWithIdentifier("MainViewSegue", sender: self)
//    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        btnGoogleAuthDisconect.hidden = true
        
        self.lblInfo.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.lblInfo.lineBreakMode = NSLineBreakMode.ByClipping
        self.lblInfo.numberOfLines = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initSpinner()

        if((keychain.ObjectForKey(kSecValueData as AnyObject)) as NSString == ""){
            self.signIn.disconnect()
            self.signIn.delegate = self;
            self.signIn.shouldFetchGooglePlusUser = true
            
            //self.signIn.clientID = kClientId
            self.signIn.homeServerClientID = kServerClientId
            
            self.signIn.scopes = [kGTLAuthScopePlusLogin]
            
            if(!self.signIn.trySilentAuthentication())
            {
                self.signIn.authenticate()
            }
        }
        else {
            println("Excists: @%", keychain.ObjectForKey(kSecValueData) as NSString)
            self.performSegueWithIdentifier("MainViewSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func validateEmail(let email: String) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluateWithObject(email)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "MainViewSegue") {
            let mvc: MainViewController = segue.destinationViewController as MainViewController
            mvc.keychain = self.keychain
        }
        
    }
    
}

