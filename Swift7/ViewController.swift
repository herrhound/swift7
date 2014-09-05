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
    var kServerClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    var kSecret: NSString = "MbSGiXXwLPaanFbJSVseW9qs"
    var responsData: NSMutableData = NSMutableData()

//    static NSString * const kClientId = @"783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com";
//    static NSString * const kServerClientId = @"783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com";
//    static NSString * const kSecret = @"MbSGiXXwLPaanFbJSVseW9qs";
    
    //"692836200741-641qul89di077cprdafcb5qs5caq6fsg.apps.googleusercontent.com"
    //var authenticated = false

    @IBOutlet var lblErrorMsg : UILabel! = nil
    @IBOutlet var texBoxExmail : UITextField! = nil
    @IBOutlet var btnRegisterDevice : UIButton! = nil
    @IBOutlet var btnCancelRegisterDevice : UIButton! = nil
    @IBOutlet var devRegisterView : UIView! = nil
    @IBOutlet var btnGoogleAuth: GPPSignInButton!
    @IBOutlet var btnGoogleAuthDisconect: UIButton!
    
    
//    override init(){
//        super.init()
//        responsData = null
//   }
    
    func disconect() -> Void {
        GPPSignIn.sharedInstance().disconnect()
    }
    
    func didDisconnectWithError(error: NSError!) -> Void{
        if (error != nil) {
            println("Received error %@", error);
        } else {
            // The user is signed out and disconnected.
            // Clean up user data as specified by the Google+ terms.
        }
    }
   
    
    @IBAction func btnGoogleAuthDisconect_TouchUpInside(sender: AnyObject) {
        self.disconect()
    }
    
    
    func presentSignInViewController(viewController: UIViewController){
        self.navigationController.pushViewController(viewController, animated:true)
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
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) -> Void {
        //println("Succeeded! Received %n bytes of data", responsData?.length)
        //println("Succeeded!")
        let str: NSString = NSString(data:responsData, encoding: NSUTF8StringEncoding)
        println("%@", str);
    }
    
    func connection(connection: NSURLConnection, error: NSError!) -> Void {
        println("%@\n", error.description)
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) -> Void {
        self.responsData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) -> Void {
        responsData.appendData(conData)
    }
    
    func doRequestCallback(let code: NSString) {
        let URLWithString = NSString(format:"https://dry-atoll-6423.herokuapp.com/oauth2callback?code=%@", code)
        let url: NSURL = NSURL(string: URLWithString)
        var request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"

        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
        
        var connection: NSURLConnection = NSURLConnection(request:request, delegate:self)
        connection.start()
//        if (connection.) {
//            responsData = NSMutableData(data)
//        }
        
        
        
//        let connection: NSURLConnection = NSURLConnection(request:request, delegate:self)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, responseData, error) in
//            if(error != nil) {
//                self.responsData = NSMutableData.data()
//            }
//        }
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication, error: NSError!) ->Void{
        if(error != nil)
        {
            println("Hello!")
            println("Received error %@ and auth object %@",error, auth)
        }
        else
        {
            var code = auth.valueForKey("code")
            self.doRequestCallback(code as NSString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorMsg.text = ""
        
        let signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = false
        
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

