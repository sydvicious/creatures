//
//  CreatureModel+CoreDataClass.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import Foundation
import CoreData

@objc(CreatureModel)
public class CreatureModel: NSManagedObject {
    enum CreatureModelDataError: Error {
        case nameCannotBeNull
    }
    
    var creature: Creature?
}
