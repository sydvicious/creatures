//
//  Prefs.swift
//  Characters
//
//  Created by Syd Polk on 12/26/14.
//  Copyright (c) 2014 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation

let NextSerial = "NextCharacterSerial"

class Prefs {
    class func getNewID() -> String {
        let uuidString = UUID().uuidString
        return uuidString
    }
}
