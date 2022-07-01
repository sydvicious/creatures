//
//  CreatureModel+CoreDataClass.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation
import CoreData

@objc(CreatureModel)
public class CreatureModel: NSManagedObject, Identifiable {
    enum CreatureModelDataError: Error {
        case nameCannotBeNull
    }
    
    var creature: Creature?
}
