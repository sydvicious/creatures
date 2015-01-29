//
//  Creature.swift
//  Creatures
//
//  Created by Syd Polk on 9/29/14.
//  Copyright (c) 2014 Bone Jarring Games and Software. All rights reserved.
//

import UIKit
import CoreData

class Creature: NSManagedObject {
    // When this is hooked up to the server, the server will have to provide a serial (or GUID)
    // for this object.
    let serial = Prefs.getNewID()
    @NSManaged var name : NSString

}
