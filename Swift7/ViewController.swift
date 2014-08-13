//
//  ViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var authenticated = false

    @IBOutlet var lblErrorMsg : UILabel! = nil
    @IBOutlet var texBoxExmail : UITextField! = nil
    @IBOutlet var btnRegisterDevice : UIButton! = nil
    @IBOutlet var btnCancelRegisterDevice : UIButton! = nil
    @IBOutlet var devRegisterView : UIView! = nil
    
    
    
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

