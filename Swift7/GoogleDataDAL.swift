//
//  GoogleDataDAL.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-10-10.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class GoogleDataDAL: BaseDAL {
    
    override init(){
        super.init()
    }
    
    func getGoogleCredential(credentialId: NSInteger) -> GoogleCredentials! {
        let opened = openDatabase()
        if(opened){
            let sql: String = "SELECT * FROM GoogleCredentials"
            let result = processSelectStatement(sql)
            if !result.isEmpty
            {
                let array = result as Array<GoogleCredentials>
//                println(array!.credentialId)
                return nil
            } 
                else {
                return GoogleCredentials()
            }
        }
        else
        {
            return GoogleCredentials()
        }

        //return result
    }
}