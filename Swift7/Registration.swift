//
//  Registration.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class Registration {

    var dal: RegistrationDAL
    
    init(){
        dal = RegistrationDAL()
    }
    
    func checkIfRegistered() -> Bool {
        return dal.registrationExists()
    }
    
    func register(let token:String) -> Bool {
        //let dal = RegistrationDAL()
        return dal.register(token)
        //return true;
    }
    
    func deleteRegistration() -> Bool {
        //let dal = RegistrationDAL()
        return dal.deleteRegistration()
        //return true;
    }
    
    func showRegistration() -> AnyObject? {
        //let dal = RegistrationDAL()
        //return dal.showRegistration()
        return nil;
    }
    
}
//db7k8198l73h6l
