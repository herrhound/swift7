//
//  NDApiRequest.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-08-12.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class NDApiRequest<G: AnyObject> {
    var AuthGuyd: NSUUID? = nil
    var DeviceUniqueId: NSUUID? = nil
    var Data: G?
    
    init(){
        AuthGuyd = nil
        DeviceUniqueId = nil
        Data = nil
    }
}