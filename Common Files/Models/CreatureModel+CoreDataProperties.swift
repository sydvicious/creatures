//
//  CreatureModel+CoreDataProperties.swift
//  Characters
//
//  Created by Syd Polk on 10/16/16.
//
//

import Foundation
import CoreData

extension CreatureModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreatureModel> {
        return NSFetchRequest<CreatureModel>(entityName: "CreatureModel");
    }

    @NSManaged public var name: String?
    @NSManaged public var oid: String?
    @NSManaged public var transactions: NSOrderedSet?

}

// MARK: Generated accessors for transactions
extension CreatureModel {

    @objc(insertObject:inTransactionsAtIndex:)
    @NSManaged public func insertIntoTransactions(_ value: CreatureModel, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [CreatureModel], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: CreatureModel)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [CreatureModel])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: CreatureModel)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: CreatureModel)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}

