//
//  UserRegister.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-08-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class UserRegisterDTO: Serializable {
    var userid: String
    var username: String
    var email: String? = nil
    var token: String? = nil
    //var tokenexpirydate: NSDate? = nil
    var Id: Int? = nil
    var verifiedemail: Bool? = nil
    var givenname: String? = nil
    var surname: String? = nil
    var link: String? = nil
    var picture: String? = nil
    var gender: Int? = nil
    var applicationid: String? = nil

    override init() {

        userid = ""
        username = ""
        email = nil
        token = nil
        //tokenexpirydate = NSDate()
        verifiedemail = nil
        Id = nil
        givenname = nil
        surname = nil
        link = nil
        picture = nil
        gender = nil
        applicationid = nil

    }
}
