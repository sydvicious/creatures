//
//  Dice.swift
//  Characters
//
//  Created by Sydney Polk on 6/9/17.
//

import Foundation

class Dice {

    static func rawRoll(dieType: Int) -> Int {
        return Int(arc4random_uniform(UInt32(dieType)) + 1)
    }

    static func roll(number: Int, dieType: Int, bonus: Int, best: Int = 0) -> Int {
        var total = 0
        if best > 0 && best < number {
            var queue = PriorityQueue<Int>()
            for _ in 1...number {
                let roll = rawRoll(dieType: dieType)
                queue.push(roll)
            }
            for _ in 1...best {
                let roll = queue.pop()
                total += roll!
            }
        } else {
            for _ in 1...number {
                let roll = rawRoll(dieType: dieType)
                total += roll
            }
        }
        total += bonus
        return total
    }
}


