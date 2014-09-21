//
//  GoogleToken.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-09-20.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class GoogleToken: NSObject {
    var access_token: NSString
    var expires_in: NSInteger
    var id_token: NSString
    var refresh_token: NSString
    var token_type: NSString
    
    init(access_token: NSString, expires_in: NSInteger, id_token: NSString, refresh_token: NSString, token_type: NSString) {
        self.access_token = access_token
        self.expires_in = expires_in
        self.id_token = id_token
        self.refresh_token = refresh_token
        self.token_type = token_type
    }
    
    func description() -> String {
        return NSString(format:"\nGoogleToken {\naccess_token = %@\nexpires_in = %n\nid_token = %@\nrefresh_token = %@\ntoken_type = %@\n}", access_token, expires_in, id_token, refresh_token, token_type)
    }

}