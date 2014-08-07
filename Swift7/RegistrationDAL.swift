//
//  RegistrationDAL.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

class RegistrationDAL: BaseDAL {
    
    override init(){
        super.init()
    }
    
    func registrationExists() -> Bool {
        let opened = openDatabase()
        if(opened){
            let sql: String = "Select skey as cnt From Settings Where skey='AuthToken2'"
            let result = processSelectStatement(sql)
            let exists: Bool = !result.isEmpty
            closeDatabase();
            return exists
        }
        else {
            return false
        }
    }
    
    func getAllSettings() -> Array<Settings> {
        let opened = openDatabase()
        if(opened){
            let sql: String = "Select * From Settings Where skey=''"
            let result = processSelectStatement(sql)
            let array = result as Array<Settings>
            closeDatabase();
            return array
        }
        else {
            return []
        }
    
    }
    
    func register() -> Bool {
        return true
    }
    
    
    func deleteRegistration() -> Bool {
        return true
    }
    
    func showRegistration() -> AnyObject? {
        return nil
    }
    
    
}