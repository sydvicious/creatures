//
//  Transaction.swift
//  Characters
//
//  Created by Syd Polk on 11/13/16.
//
//

import UIKit

class Transaction: NSObject {
    public let _section: String
    public let _source: String
    public let _attribute: String
    public let _subattribute: String
    public let _value: String
    public let _duration: Int
    public let _timestamp: NSDate
    public let _oid: String

    init(section: String, source: String, attribute: String, subattribute: String, value: String, duration: Int) {
        _section = section
        _source = source
        _attribute = attribute
        _subattribute = subattribute
        _value = value
        _duration = duration
        _timestamp = NSDate()
        _oid = Prefs.getNewID()
    }
}
