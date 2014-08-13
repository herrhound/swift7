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
    
    func sendRegistrationRequest(let email: String, let devuniqueid: String) {
        var success: Bool = false;
        var url = NSURL(string: "http://dry-atoll-6423.herokuapp.com/registeruser")
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var model = UserRegisterDTO()
        model.userid = NSUUID.UUID().UUIDString
        model.applicationid = NSUUID.UUID().UUIDString
        model.email = email
        model.username = email
        model.surname = "Tonkev"
        model.givenname = "Nikola"
        model.gender = Int(1)
        
        let jsonString = model.toJsonString()
        //println(jsonString)
        
        var requestBodyData: NSData = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = requestBodyData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, responseData, error) in
            if error != nil
            {
                println(error.description)
                //success = false
                
            }
            else
            {
                var responseStr: NSString = NSString(data:responseData, encoding:NSUTF8StringEncoding)
                println(responseStr)

                /*
                var err: NSError?
                let obj = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers, error: &err) as NDApiResponse<String>
                if(err != nil){
                    println(err?.description)
                }
                println(obj)
                */
                //success = true
            }
        }
        
        //return success;
    }
    
    func register(let token:String) -> Bool {
        //let dal = RegistrationDAL()
        //return dal.register(token)
        return true;
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
