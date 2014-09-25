//
//  ViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GPPSignInDelegate {
    
    
    //var signIn: GPPSignIn
    var kClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    var kServerClientId: NSString = "783241267105-bc7pq09tr1nnogat72r9tgmaeg2mre28.apps.googleusercontent.com"
    var kSecret: NSString = "MbSGiXXwLPaanFbJSVseW9qs"
    var responsData: NSMutableData = NSMutableData()
    var credentials: GTMOAuth2Authentication!
    
    
    @IBOutlet var lblErrorMsg : UILabel! = nil
    @IBOutlet var texBoxExmail : UITextField! = nil
    @IBOutlet var btnRegisterDevice : UIButton! = nil
    @IBOutlet var btnCancelRegisterDevice : UIButton! = nil
    @IBOutlet var devRegisterView : UIView! = nil
    @IBOutlet var btnGoogleAuth: GPPSignInButton!
    @IBOutlet var btnGoogleAuthDisconect: UIButton!
    
    
    func disconect() -> Void {
        GPPSignIn.sharedInstance().disconnect()
    }
//    
//    func didDisconnectWithError(error: NSError!) -> Void{
//        if (error != nil) {
//            println("Received error %@", error);
//        } else {
//            // The user is signed out and disconnected.
//            // Clean up user data as specified by the Google+ terms.
//        }
//    }
   
    
    @IBAction func btnGoogleAuthDisconect_TouchUpInside(sender: AnyObject) {
        self.disconect()
    }
    
    @IBAction func EditingEmailDidEnd(sender : AnyObject) {
        texBoxExmail.resignFirstResponder()
    }
    
    @IBAction func btnRegisterDeviceTouchUpInside(sender : AnyObject) {
        texBoxExmail.resignFirstResponder()
        return;
    }
        
    @IBAction func btnCancelRegisterDeviceTouchUpInside(sender : AnyObject) {
        texBoxExmail.resignFirstResponder()
        texBoxExmail.text = ""
    }
    
    func presentSignInViewController(viewController: UIViewController){
        navigationController?.pushViewController(self, animated:true)
    }

    func doRequestCallback(let code: NSString) {
        var err: NSError?
        let URLWithString = NSString(format:"https://dry-atoll-6423.herokuapp.com/oauth2callback?code=%@", code)
        let url: NSURL = NSURL(string: URLWithString)
        var request = NSMutableURLRequest(URL:url)

        request.HTTPMethod = "GET"

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),completionHandler: {(response, data, err) -> Void in
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            
            let googleToken = GoogleToken(access_token: jsonResult.valueForKey("access_token") as String, expires_in: jsonResult.valueForKey("expires_in") as Int, id_token: jsonResult.valueForKey("id_token") as String, refresh_token: jsonResult.valueForKey("refresh_token") as String, token_type: jsonResult.valueForKey("token_type")as String)
            println(googleToken)
            
            self.doRegisterUser(googleToken.access_token)
            
        })
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
            println("Received error %@ and auth object %@",error, auth)
        }
        else
        {
            let signIn = GPPSignIn.sharedInstance()
            let serverCode: NSString = signIn.homeServerAuthorizationCode;
            self.doRequestCallback(serverCode as NSString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorMsg.text = ""
        
        let signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = true
        
        signIn.clientID = kClientId
        signIn.homeServerClientID = kServerClientId
        
        signIn.scopes = [kGTLAuthScopePlusLogin]
        
        signIn.delegate = self;
        //signIn.authenticate()
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        super.viewDidAppear(animated)
        let reg = Registration()
        let success = reg.checkIfRegistered()
        if(success){
            self.performSegueWithIdentifier("MainViewSegue", sender: self)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func validateEmail(let email: String) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluateWithObject(email)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        /*
        if(true) {
            return true
        }
        else {
            if(self.texBoxExmail.text.isEmpty ) {
                self.lblErrorMsg.text = "Please provide an e-mail !"
                return false
            }
            if(!validateEmail(self.texBoxExmail.text)){
                self.lblErrorMsg.text = "Please provide an valid e-mail !"
                return false
            }
            
            self.lblErrorMsg.text = ""
            let reg = Registration()
            reg.sendRegistrationRequest(self.texBoxExmail.text, devuniqueid: "sdfsdfsdf-646dstwer645-34tert63256-terwt342563")
            return false
            //return reg.register("sdfsdfsdf-646dstwer645-34tert63256-terwt342563")
        }
        */
        return true
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        /*
        if (segue.identifier == "MainViewSegue") {
            let mvc: MainViewController = segue.destinationViewController as MainViewController
        }
        */
    }
    
    //helpers
    func regUsrCallback(let requestData: NSData){
        println("Hello")
    }

}

