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
            let sql: String = "Select skey as cnt From Settings Where skey='AuthToken'"
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
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as String
        let opened = openDatabase()
        if(opened){
            let sql: String = "Select * From Settings"
            let result = processSelectStatement(sql)
            let array = result as Array<Settings>
            closeDatabase();
            return array
        }
        else {
            return []
        }
    
    }
    
    func register(let token: String) -> Bool {
        let opened = openDatabase()
        if(opened){
            let sql: String = "Insert Into Settings(skey, svalue) Values('AuthToken', '" + token + "')"
            let success = processExecuteStatement(sql)
            closeDatabase();
            return success
        }
        else {
            return false
        }
    }
    
    
    func deleteRegistration() -> Bool {
        let opened = openDatabase()
        if(opened){
            let sql: String = "Delete From Settings Where skey='AuthToken'"
            let success = processExecuteStatement(sql)
            closeDatabase();
            return success
        }
        else {
            return false
        }
    }
    
    func showRegistration() -> AnyObject? {
        return nil
    }
    
    
}