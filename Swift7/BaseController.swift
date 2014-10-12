//
//  BaseController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-10-11.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit
import Security
import SystemConfiguration

class BaseViewController: UIViewController {
    
    var alerttView: UIView!
    var googleCredentials: GoogleCredentials!
    var hasInternetConnection: Bool = true
    
    func showAlertView()
    {
        if(alerttView != nil)
        {
            alerttView.hidden = false
        }
    }
    
    func hideAlertView()
    {
        if(alerttView != nil)
        {
            alerttView.hidden = true
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        hideAlertView()
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        let success = (isReachable && !needsConnection) ? true : false
        if(!success){
            showAlertView()
        }
        
        return success
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let sbHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        let applicationFrame: CGRect  = UIScreen.mainScreen().applicationFrame
        alerttView = AlertViewController().view
        alerttView.backgroundColor = UIColor.grayColor()
        alerttView.frame = CGRectMake(0, sbHeight, applicationFrame.width, 30)
        self.view.addSubview(alerttView)
        alerttView.hidden = true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        hasInternetConnection = isConnectedToNetwork()
    }
    
}

