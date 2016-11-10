//
//  Transactions+CoreDataProperties.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import Foundation
import CoreData

extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions");
    }

    @NSManaged public var action: String?
    @NSManaged public var source: String?
    @NSManaged public var type: String?
    @NSManaged public var value: String?
    @NSManaged public var duration: NSNumber?
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var oid: String?
    @NSManaged public var creature: CreatureModel?

}
