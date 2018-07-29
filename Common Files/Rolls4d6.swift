//
//  Rolls4d6.swift
//  iOS
//
//  Created by Syd Polk on 7/28/18.
//

import UIKit

class Rolls4d6 {
    let rolls = Dice.rolls(number: 4, dieType: 6)
    
    func minimumIndex() -> Int {
        var minimumScore = 10000
        var minimumIndex = -1
        for i in 0...3 {
            if (rolls[i] < minimumScore) {
                minimumScore = rolls[i]
                minimumIndex = i
            }
        }
        return minimumIndex
    }
    
    func score() -> Int {
        var score = 0
        for i in 0...3 {
            score += rolls[i]
        }
        score -= rolls[self.minimumIndex()]
        return score
    }
}
