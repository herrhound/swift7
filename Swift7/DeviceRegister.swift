//
//  DeviceRegister.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-08-07.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation
import CoreData

class DeviceRegister: Serializable {
    var email: String
    var deviceUniqueId: String
    
    override init() {
        email = ""
        deviceUniqueId = ""
    }
/*
    init(let _email: String, let _deviceUniqueId: String){
        email = _email
        deviceUniqueId = _deviceUniqueId
    }
*/
}
