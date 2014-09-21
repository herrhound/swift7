//
//  NDApiRequestSender.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-08-12.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class NDApiRequestSender {
    
    let svrUrl: String = "http://dry-atoll-6423.herokuapp.com/"
    
    func sendAsyncRequest<G>(let apiName: String, let httpMethod: String, let requestData: G, callback: (NSData)? -> Void) -> Bool {
        var success: Bool = false
        var url = NSURL(string: svrUrl + "registeruser")
        var request = NSMutableURLRequest(URL: url)

        request.HTTPMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonString = (requestData as Serializable).toJsonString()
        var requestBodyData: NSData! = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = requestBodyData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) -> Void in
            success = (error != nil)
            if(success) {
                //success =
                //callback(responseData)
            }
        }
        
        return success;
        
    }
    
}
