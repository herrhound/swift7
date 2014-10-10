//
//  MainViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var lblRegInfo : UILabel! = nil
    @IBOutlet var btnDeleteRegistration : UIButton! = nil
    @IBOutlet var btnShowRegistration : UIButton! = nil
    
    var keychain: KeychainWrapper!

    @IBAction func btnDeleteRegistrationTouchUpInside(sender : AnyObject) {
        keychain.resetKeychainItem()
//        let reg = Registration()
//        let success = reg.deleteRegistration()
//        if(success){
//            lblRegInfo.text = "Reggistration deleted!"
//        }
//        else{
//            lblRegInfo.text = "Error while delete reggistration!"
//        }
    }
    
    
    @IBAction func btnShowRegistrationTouchUpInside(sender : AnyObject) {
        /*
        let reg = Registration()
        let entity = reg.showRegistration()
        if(entity != nil){
            let a = entity? as RegEntiry
            lblRegInfo.text = a.authguid + "\t" + a.deviceuid
        }
        else{
            lblRegInfo.text = "No reggistration found!"
        }
*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //lblRegInfo.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
