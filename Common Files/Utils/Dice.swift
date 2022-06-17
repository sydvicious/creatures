//
//  Dice.swift
//  Characters
//
//  Created by Sydney Polk on 6/9/17.
//  Copyright (c) 2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import Foundation

struct IndexRollPair: Comparable {
    static func < (lhs: IndexRollPair, rhs: IndexRollPair) -> Bool {
        return lhs.score < rhs.score
    }
    
    static func == (lhs: IndexRollPair, rhs: IndexRollPair) -> Bool {
        return lhs.score == rhs.score
    }
    
    let index: Int
    let score: Int
    
    init(index: Int, score: Int) {
        self.index = index
        self.score = score
    }
    
    
}


class Dice {

    static func rawRoll(dieType: Int) -> Int {
        return Int(arc4random_uniform(UInt32(dieType)) + 1)
    }
    
    static func rolls(number: Int, dieType: Int, sorted : Bool = false) -> [Int] {
        var rolls : [Int] = []
        
        if (sorted) {
            var queue = PriorityQueue<Int>()
            for _ in 1...number {
                let roll = rawRoll(dieType: dieType)
                queue.push(roll)
            }
            while ((queue.peek()) != nil) {
                if let roll = queue.pop() {
                    rolls.append(roll)
                }
            }
        } else {
            for _ in 1...number {
                rolls.append(rawRoll(dieType: dieType))
            }
        }
        return rolls
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
    
    static func takeRolls(rolls: [Int], best: Int) -> Int {
        var total = 0
        var queue = PriorityQueue<Int>.init(ascending: false, startingValues: rolls)
        for _ in 1...best {
            let roll = queue.pop()
            total += roll!
        }
        return total
    }
    
    static func miminumIndex(rolls: [Int]) -> Int {
        var minIndex = -1
        var minValue = 10000 // Need MAX_INT
        
        var index = 0
        while (index < rolls.count) {
            if (rolls[index] < minValue) {
                minIndex = index
                minValue = rolls[index]
            }
            index += 1
        }
        return minIndex
    }
}


