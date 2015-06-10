//
//  Prefs.swift
//  Creatures
//
//  Created by Syd Polk on 12/26/14.
//
//

import Foundation

let NextSerial = "NextCharacterSerial"

class Prefs {
    class func getNewID() -> NSString {
        let uuidString = NSUUID().UUIDString
        return uuidString
    }
}