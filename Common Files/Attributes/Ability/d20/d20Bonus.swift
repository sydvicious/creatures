//
//  d20Bonus.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import UIKit

enum d20BonusState {
    case Permanent
    case Temporary
    case Expired
}

struct d20BonusInfo {
    let value: Int
    var rounds: Int
    var state: d20BonusState
    
    init(newPermanentValue newValue: Int) {
        value = newValue
        state = .Permanent
        rounds = 0
    }
    
    init(newTemporaryValue newValue: Int, withRounds numRounds: Int) {
        value = newValue
        state = .Temporary
        rounds = numRounds
    }
    
    mutating func decrementRounds() -> d20BonusState {
        if state == .Temporary {
            rounds = rounds - 1
            if (rounds == 0) {
                self.state = .Expired
            }
        }
        return state
    }
}

struct d20BonusBySource {
    var bonusInfos = [String: d20BonusInfo]()

    mutating func addPermanent(withSource source: String, withValue newValue: Int)  {
        let info = d20BonusInfo.init(newPermanentValue: newValue)
        bonusInfos.updateValue(info, forKey: source)
    }
    
    mutating func addTemporary(withSource source: String, withValue newValue: Int, withRounds numRounds: Int) {
        let info = d20BonusInfo.init(newTemporaryValue: newValue, withRounds: numRounds)
        bonusInfos.updateValue(info, forKey: source)
    }
    
    mutating func remove(source: String) {
        if bonusInfos[source] != nil {
            bonusInfos.removeValue(forKey: source)
        }
    }
    
    var isEmpty: Bool {
        get {
            return bonusInfos.isEmpty
        }
    }
    
    func netValue() -> Int {
        if bonusInfos.isEmpty {
            return 0
        }
        var returnValue = -9999
        for (_, bonusInfo) in bonusInfos {
            if bonusInfo.value > returnValue {
                returnValue = bonusInfo.value
            }
        }
        return returnValue
    }
    
    mutating func decrementRounds() -> d20BonusState {
        for (source, var bonusInfo) in bonusInfos {
            let d20BonusState = bonusInfo.decrementRounds()
            if d20BonusState == .Expired {
                bonusInfos.removeValue(forKey: source)
            } else if d20BonusState == .Temporary {
                bonusInfos.updateValue(bonusInfo, forKey: source)
            }
        }
        if bonusInfos.isEmpty {
            return .Expired
        }
        return .Temporary
    }
}

struct d20Bonus {
    var bonuses = [String: d20BonusBySource]()

    mutating func addPermanent(_ type: String, fromSource newSource: String, withValue newValue: Int) {
        if bonuses[type] == nil {
            bonuses[type] = d20BonusBySource()
        }
        var bonusInfo = bonuses[type]
        bonusInfo?.addPermanent(withSource: newSource, withValue: newValue)
        bonuses.updateValue(bonusInfo!, forKey: type)
    }
    
    mutating func addTemporary(_ type: String, fromSource newSource: String, withValue newValue: Int, withRounds numRounds: Int) {
        if bonuses[type] == nil {
            bonuses[type] = d20BonusBySource()
        }
        var bonusInfo = bonuses[type]
        bonusInfo?.addTemporary(withSource: newSource, withValue: newValue, withRounds: numRounds)
        bonuses.updateValue(bonusInfo!, forKey: type)
    }
    
    mutating func remove(_ type: String, fromSource source: String) {
        if var bonusInfos = bonuses[type] {
            bonusInfos.remove(source: source)
            if (bonusInfos.isEmpty) {
                bonuses.removeValue(forKey: type)
            } else {
                bonuses.updateValue(bonusInfos, forKey: type)
            }
        }
    }
    
    func netValue(_ type: String) -> Int {
        if let bonus = bonuses[type] {
            return bonus.netValue()
        } else {
            return 0
        }
    }
    
    func netValue() -> Int {
        var result = 0
        for (type, _) in bonuses {
            result = result + self.netValue(type)
        }
        return result
    }
    
    mutating func decrementRounds(_ type: String) {
        for (type, var bonus) in bonuses {
            if bonus.decrementRounds() == .Expired {
                bonuses.removeValue(forKey: type)
            } else {
                bonuses.updateValue(bonus, forKey: type)
            }
        }
    }
    
    mutating func decrementRounds() {
        for (type, _) in bonuses {
            self.decrementRounds(type)
        }
    }
    
    var isEmpty: Bool {
        get {
            return bonuses.isEmpty
        }
    }
 }
