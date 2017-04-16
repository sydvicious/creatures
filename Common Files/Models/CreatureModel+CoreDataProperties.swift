//
//  CreatureModel+CoreDataProperties.swift
//  Characters
//
//  Created by Syd Polk on 12/31/16.
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
    @NSManaged public func insertIntoTransactions(_ value: TransactionsModel, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [TransactionsModel], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: TransactionsModel)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [TransactionsModel])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionsModel)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionsModel)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}
