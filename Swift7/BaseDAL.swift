//
//  BaseDAL.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation

class BaseDAL {
    var sqliteDatabase: SqliteDatabase
    
    
    init(){
        var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            return urls[urls.endIndex-1] as NSURL
        }

        let dbFileName: String = "Swift7.sqlite"
        //var dbPath = applicationDocumentsDirectory.URLByAppendingPathComponent(dbFileName).path
        var bundle: NSBundle = NSBundle.mainBundle()
        var dbPath: NSString = bundle.resourcePath + "/" + dbFileName
        //println(dbPath)
        self.sqliteDatabase = SqliteDatabase(path: dbPath)
    }

    func processSelectStatement(let sql: String) -> Array<AnyObject> {
        return sqliteDatabase.processSelectStatement(sql)
    }

    func processExecuteStatement(let sql: String) -> Bool
    {
        return sqliteDatabase.processExecuteStatement(sql)
    }
    /*
    func lastInsertedRowID() -> Int32 {
        return sqliteDatabase.lastInsertedRowID()
    }
    */
    func openDatabase() -> Bool {
        return sqliteDatabase.openDatabase()
    }
    
    func closeDatabase() {
        sqliteDatabase.closeDatabase()
    }
    
    func beginTransaction() -> Bool {
        return sqliteDatabase.beginTransaction()
    }
    
    func commitTransaction() -> Bool {
        return sqliteDatabase.commitTransaction()
    }
    
    func rollbackTransaction() -> Bool
    {
        return sqliteDatabase.rollbackTransaction()
    }
    
}