//
//  CreatureModel.swift
//  Characters
//
//  Created by Syd Polk on 9/29/14.
//  Copyright (c) 2014 Bone Jarring Games and Software. All rights reserved.
//

import Foundation
import CoreData

class CreatureModel: NSManagedObject {
    enum CreatureModelDataError: Error {
        case nameCannotBeNull
    }

    @NSManaged var name : String
    @NSManaged var oid: String
}
