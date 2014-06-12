//
//  RegistrationDAL.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import CoreData

class RegistrationDAL: BaseDAL {

    func registrationExists() -> Bool {
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "RegEntity")
        let result: Int = self.cdh.managedObjectContext.countForFetchRequest(fReq, error:&error)
        if(!error){
            return result > 0
        }
        else
        {
            return false
        }
    }
    
    func register() -> Bool {
        var newItem = NSEntityDescription.insertNewObjectForEntityForName("RegEntity", inManagedObjectContext: self.cdh.managedObjectContext) as NSManagedObject
        
        newItem.setValue("dssfsdf", forKey: "authguid")
        newItem.setValue("asdadasda", forKey: "deviceuid")
        self.cdh.saveContext()
        return true
    }
    
    
    func deleteRegistration() -> Bool {
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "RegEntity")
        var models: NSArray = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        for entity: AnyObject in models {
           let obj = entity as NSManagedObject
           self.cdh.managedObjectContext.deleteObject(obj)
        }
        self.cdh.saveContext()
        return true
    }
    
    func showRegistration() -> AnyObject? {
        let dal = RegistrationDAL()
        var error: NSError? = nil
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "RegEntity")
        var models: NSArray = self.cdh.managedObjectContext.executeFetchRequest(fReq, error:&error)
        if(models.count > 0)
        {
            return models.firstObject
        }
        else
        {
            return nil
        }
    }
    
    
}