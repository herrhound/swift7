//
//  GoogleCredentials.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-10-10.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class GoogleCredentials {
    var credentialId: Int //NSInteger
    var kClientId: String //NSString
    var kServerClientId: String //NSString
    var kSecret: String //NSString
    
    
    init(){
        credentialId = 0
        kClientId = ""
        kServerClientId = ""
        kSecret = ""
    }
    
    /*
    init(credentialId: NSInteger, kClientId: NSString, kServerClientId: NSString, kSecret: NSString) {
        self.credentialId = credentialId
        self.kClientId = kClientId
        self.kServerClientId = kServerClientId
        self.kSecret = kSecret
    }
    
    func description() -> String {
        return NSString(format:"\nGoogleCredentials {\ncredentialId = %n\nkClientId = %@\nkServerClientId = %@\nkSecret = %@\n}", credentialId, kClientId, kServerClientId, kSecret)
    }
    */
}