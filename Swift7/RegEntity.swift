//
//  RegEntity.swift
//  Swift7
//
//  Created by Nikola Tonkev on 2014-06-08.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

import Foundation
import CoreData

class RegEntiry: NSManagedObject {
    @NSManaged var authguid: String
    @NSManaged var deviceuid: String
}
