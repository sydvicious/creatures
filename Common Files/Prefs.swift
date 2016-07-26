//
//  Prefs.swift
//  Characters
//
//  Created by Syd Polk on 12/26/14.
//
//

import Foundation

let NextSerial = "NextCharacterSerial"

class Prefs {
    class func getNewID() -> NSString {
        let uuidString = UUID().uuidString
        return uuidString
    }
}
