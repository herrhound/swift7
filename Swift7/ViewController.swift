//
//  ViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GPPSignInDelegate {
    
    let kClientId: NSString = "783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com"
    //"692836200741-641qul89di077cprdafcb5qs5caq6fsg.apps.googleusercontent.com"
    var authenticated = false

    @IBOutlet var lblErrorMsg : UILabel! = nil
    @IBOutlet var texBoxExmail : UITextField! = nil
    @IBOutlet var btnRegisterDevice : UIButton! = nil
    @IBOutlet var btnCancelRegisterDevice : UIButton! = nil
    @IBOutlet var devRegisterView : UIView! = nil
    @IBOutlet  var btnGoogleAuth: UIButton!
    
    @IBAction func btnGoogleAuth_TouchUpInside(sender: AnyObject) {
        println("Google")
    }
    
    func finishedWithAuth(let auth: GTMOAuth2Authentication, let error: NSError) {
        if(error != nil)
        {
            println("Received error %@ and auth object %@",error, auth)
        }
        else
        {
            let serverCode: NSString = GPPSignIn.sharedInstance().homeServerAuthorizationCode
        }
    }
    /*
    func presentSignInViewController(let viewController: UIViewController){
        
    }
    */
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorMsg.text = ""
        
        let signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = true
        
        // You previously set kClientId in the "Initialize the Google+ client" step
        signIn.clientID = kClientId;

        signIn.homeServerClientID = "783241267105-m2ufvgncm0n70nfc2upc2mv87ogjsn6b.apps.googleusercontent.com";

        // Uncomment one of these two statements for the scope you chose in the previous step
        signIn.scopes = [kGTLAuthScopePlusLogin] //"https://www.googleapis.com/auth/plus.login"
        //signIn.scopes = @[ @"profile" ];            // "profile" scope
        
        // Optional: declare signIn.actions, see "app activities"
        signIn.delegate = self;
        
        /*
        let signIn = GPPSignIn.sharedInstance()
        signIn.shouldFetchGooglePlusUser = true
        //signIn.shouldFetchGoogleUserEmail = true  // Uncomment to get the user's email
        
        // You previously set kClientId in the "Initialize the Google+ client" step
        signIn.clientID = kClientId;
        
        // Uncomment one of these two statements for the scope you chose in the previous step
        signIn.scopes = [kGTLAuthScopePlusLogin] //"https://www.googleapis.com/auth/plus.login"
        //signIn.scopes = @[ @"profile" ];            // "profile" scope
        
        // Optional: declare signIn.actions, see "app activities"
        signIn.delegate = self;
        */

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let reg = Registration()
        let success = reg.checkIfRegistered()
        if(success){
            self.performSegueWithIdentifier("MainViewSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func validateEmail(let email: String) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluateWithObject(email)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if(authenticated) {
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
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "MainViewSegue") {
            let mvc: MainViewController = segue.destinationViewController as MainViewController
        }
    }
    
    //helpers
    func regUsrCallback(let requestData: NSData){
        println("Hello")
    }

}

