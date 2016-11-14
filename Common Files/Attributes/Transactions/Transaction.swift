//
//  Transaction.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//
//

import UIKit

class Transaction: NSObject {
    public let _action: String
    public let _source: String
    public let _type: String
    public let _value: String
    public let _duration: Int
    public let _timestamp: NSDate
    public let _oid: String

    init(action: String, source: String, type: String, value: String, duration: Int) {
        _action = action
        _source = source
        _type = type
        _value = value
        _duration = duration
        _timestamp = NSDate()
        _oid = Prefs.getNewID()
    }
}
