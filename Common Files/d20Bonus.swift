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
    
    init(_ newValue: Int, makePermanent isPermanent: Bool, withRounds numRounds: Int) {
        value = newValue
        if isPermanent {
            state = .Permanent
        } else {
            state = .Temporary
        }
        rounds = numRounds
    }
    
    mutating func decrementRounds() -> d20BonusState {
        if state == .Temporary {
            rounds -= 1
            if (rounds == 0) {
                self.state = .Expired
            }
        }
        return state
    }
}

struct d20BonusInfoDict {
    var bonusInfos = [String: d20BonusInfo]()
    
    mutating func add(withSource source: String, withValue newValue: Int, makePermanent isPermanent: Bool, withRounds numRounds: Int)  {
        let info = d20BonusInfo.init(newValue, makePermanent: isPermanent, withRounds: numRounds)
        bonusInfos.updateValue(info, forKey: source)
    }
    
    mutating func remove(source: String) {
        if bonusInfos[source] != nil {
            bonusInfos.removeValue(forKey: source)
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
            if bonusInfo.decrementRounds() == .Expired {
                bonusInfos.removeValue(forKey: source)
            }
        }
        if bonusInfos.isEmpty {
            return .Expired
        }
        return .Temporary
    }
}


struct d20Bonus {
    var bonuses = [String: d20BonusInfoDict]()

    mutating func add(_ type: String, fromSource newSource: String, withValue newValue: Int, makePermanent isPermanent: Bool, withRounds numRounds: Int) {
        if bonuses[type] == nil {
            bonuses[type] = d20BonusInfoDict()
        }
        var bonusInfo = bonuses[type]
        bonusInfo?.add(withSource: newSource, withValue: newValue, makePermanent: isPermanent, withRounds: numRounds)
    }
    
    func remove(source: String, fromType type: String) {
        if var bonusInfos = bonuses[type] {
            bonusInfos.remove(source: source)
        }
    }
    
    func netValue(forType type: String) -> Int {
        if let bonus = bonuses[type] {
            return bonus.netValue()
        } else {
            return 0
        }
    }
    
    mutating func decrementRounds(forType type: String) {
        for (type, var bonus) in bonuses {
            if bonus.decrementRounds() == .Expired {
                bonuses.removeValue(forKey: type)
            }
        }
    }
 }

class d20Bonuses: NSObject {
    var bonuses = [String: d20Bonus]()

    func add(type: String, fromSource newSource: String, withValue newValue: Int, makePermanent isPermanent: Bool, withRounds numRounds: Int) {
        var bonus: d20Bonus

        if bonuses[type] == nil {
            bonus = d20Bonus()
        } else {
            bonus = bonuses[type]!
        }
     
        bonus.add(type, fromSource: newSource, withValue: newValue, makePermanent: isPermanent, withRounds: numRounds)
        
    }
    
    func remove(source: String, fromType type: String) {
        if let bonus = bonuses[type] {
            bonus.remove(source: source, fromType: type)
        }
    }
    
    func netValue() -> Int {
        var total = 0
        for (type, bonus) in bonuses {
            total += bonus.netValue(forType: type)
        }
        return total
    }
    
    func decrementRounds() {
        for (type, var bonus) in bonuses {
            bonus.decrementRounds(forType: type)
        }
    }
}

