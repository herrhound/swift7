//
//  GoogleUserInfo.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-09-20.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class GoogleUserInfo {
    var family_name: NSString
    var gender: NSString
    var given_name: NSString
    var id: NSString
    var link: NSString
    var locale: NSString
    var name: NSString
    var picture: NSString
    
    init(data: NSDictionary){
        self.name = data.valueForKey("name") as String
        self.family_name = data.valueForKey("family_name") as String
        self.gender = data.valueForKey("gender") as String
        self.given_name = data.valueForKey("given_name") as String
        self.id = data.valueForKey("id") as String
        self.link = data.valueForKey("link") as String
        self.locale = data.valueForKey("locale") as String
        self.picture = data.valueForKey("picture") as String
    }
}