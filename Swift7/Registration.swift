//
//  Registration.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class Registration {

    func checkIfRegistered() -> Bool {
        let dal = RegistrationDAL()
        return dal.registrationExists();
    }
    
    func register() -> Bool {
        let dal = RegistrationDAL()
        return dal.register()
    }
    
    func deleteRegistration() -> Bool {
        let dal = RegistrationDAL()
        return dal.deleteRegistration()
    }
    
    func showRegistration() -> AnyObject? {
        let dal = RegistrationDAL()
        return dal.showRegistration()
    }
    
}
//db7k8198l73h6l
