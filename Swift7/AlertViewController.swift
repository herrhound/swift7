//
//  AlertViewController.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-10-11.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import UIKit
import Security

class AlertViewController: UIViewController
{
    @IBOutlet var lblAlert: UILabel!
    @IBOutlet var btnHideAlert: UIButton!
    
    override func loadView()
    {
        super.loadView()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.lblAlert.backgroundColor = UIColor.redColor()
        self.lblAlert.frame = CGRectMake(0, 0, self.lblAlert.bounds.width, self.lblAlert.bounds.height)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}
