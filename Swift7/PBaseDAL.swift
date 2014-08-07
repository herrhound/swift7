//
//  PBaseDAL.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-21.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation


protocol PBaseDAL {
    func processSelectStatement(let sql: String) -> NSArray
    func processExecuteStatement(let sql: String) -> Bool
    //func lastInsertedRowID() -> Int32
    func openDatabase() -> Bool
    func closeDatabase()
    func beginTransaction() -> Bool
    func commitTransaction() -> Bool
    func rollbackTransaction() -> Bool
}