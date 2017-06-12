//
//  d20Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation

public enum Abilities {
    case Strength
    case Dexterity
    case Constitution
    case Intelligence
    case Wisdom
    case Charisma
}

protocol d20AbilityVars {
    var bonus : d20Bonus { get }
}

class d20Ability: Ability {
    var bonus: d20Bonus

    public static let abilityStrings : [String] = [
        "Strength",
        "Dexterity",
        "Constitution",
        "Intelligence",
        "Wisdom",
        "Charisma"
    ]

    static public let AbilityMap: [String:Abilities] = [
        "strength": .Strength,
        "dexterity": .Dexterity,
        "constitution": .Constitution,
        "intelligence": .Intelligence,
        "wisdom": .Wisdom,
        "charisma": .Charisma
    ]

    override var currentScore : Int {
        get {
            return self.baseScore + self.bonus.netValue()
        }
    }

    override init(name: String, score: Int) {
        bonus = d20Bonus()
        super.init(name: name, score: score)
    }

    convenience init(name: String, score: Int, transactions: TransactionsController) {
        self.init(name: name, score: score)
        save_transaction(transactions, section: "ability", attribute: name, source: "creation", type: "base", value: String(score), duration: -1)
    }
    
    override func save_transaction(_ transactions: TransactionsController, section: String, attribute: String, source: String, type: String, value: String, duration: Int) {
        let trans = Transaction(system: "d20", section: section, attribute: attribute, source: source, type: type, value: value, duration: duration)
        transactions.add(transaction: trans)
    }

}

extension d20Ability: d20AbilityVars {
    var modifier: Int {
        let normalized : Double = Double(currentScore - 10)
        let half = normalized / 2.0
        let result = floor(half)
        return Int(result)
    }
}

protocol d20BonusSpells {
    func bonusSpells(forLevel level: Int) -> Int
}

extension d20Ability: d20BonusSpells {
    func bonusSpells(forLevel level: Int) -> Int {
        if level < 1 || level > 9 {
            return 0
        }
        if (self.modifier - level) < 0 {
            return 0
        }
        return Int(ceil(Double(self.modifier - level + 1 / 4)))
    }
}

protocol d20Strength {
    func lightLoad() -> Int
    func mediumLoad() -> Int
    func heavyLoad() -> Int
}

let lightLoads: [Int] = [0, 3, 6, 10, 13, 16, 20, 23, 26, 30, 33, 38, 43, 50, 58, 66, 76, 86, 100, 116, 133, 153, 173, 200, 233, 266, 306, 346, 400, 466]
let mediumLoads: [Int] = [0, 6, 13, 20, 26, 33, 40, 46, 53, 60, 66, 76, 86, 100, 116, 133, 153, 173, 200, 233, 266, 306, 346, 400, 466, 533, 613, 693, 800, 933]
let heavyLoads: [Int] = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 115, 130, 150, 175, 200, 230, 260, 300, 350, 400, 460, 520, 600, 700, 800, 920, 1040, 1200, 1400]

extension d20Ability: d20Strength {
    
    private func load(whichArray: [Int]) -> Int {
        if currentScore > 29 {
            let remainder = currentScore - 30
            let decades = Int(remainder / 10)
            let lastDigit = remainder - (decades * 10)
            let fromArray = whichArray[20 + lastDigit]
            return fromArray * (decades + 1) * 4
        }
        return whichArray[currentScore]

    }
    
    func lightLoad() -> Int {
        return load(whichArray: lightLoads)
    }

    func mediumLoad() -> Int {
        return load(whichArray: mediumLoads)
    }

    func heavyLoad() -> Int {
        return load(whichArray: heavyLoads)
    }

}
