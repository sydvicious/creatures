//
//  Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import UIKit

class Ability {
    let sectionName = "abilities"
    private var _baseScore: Int
    
    var baseScore: Int {
        get {
            return self._baseScore
        }
        set {
            if newValue < 0 {
                self._baseScore = 0
            } else {
                self._baseScore = newValue
            }
        }
    }
    
    init(score: Int) {
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
    }
    
    func transactions(name: String) -> [Transaction] {
        let baseScoreTransaction = Transaction(section: sectionName, attribute: name, subattribute: "base", value: String(self._baseScore), duration: -1)
        return [baseScoreTransaction]
    }
}

