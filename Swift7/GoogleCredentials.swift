//
//  GoogleCredentials.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-10-10.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class GoogleCredentials {
    var kClientId: String //NSString
    var kServerClientId: String //NSString
    
    
    init(){
        kClientId = ""
        kServerClientId = ""
    }
    
    init(data: NSDictionary){
        self.kClientId = data.valueForKey("client_id") as String
        self.kServerClientId = data.valueForKey("server_id") as String
    }
    
    init(kClientId: NSString, kServerClientId: NSString) {
        self.kClientId = kClientId
        self.kServerClientId = kServerClientId
    }
    
    func description() -> String {
        return NSString(format:"\nGoogleCredentials {\nkClientId = %@\nkServerClientId = %@\n}", kClientId, kServerClientId)
    }
}