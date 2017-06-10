//
//  Dice.swift
//  Characters
//
//  Created by Sydney Polk on 6/9/17.
//

import Foundation

class Dice {
    static func roll4d6best3() -> Int {
        var queue = PriorityQueue<Int>()
        var roll = Int(arc4random_uniform(6) + 1)
        queue.push(roll)
        roll = Int(arc4random_uniform(6) + 1)
        queue.push(roll)
        roll = Int(arc4random_uniform(6) + 1)
        queue.push(roll)
        roll = Int(arc4random_uniform(6) + 1)
        queue.push(roll)
        roll = queue.pop()!
        var total = roll
        roll = queue.pop()!
        total += roll
        roll = queue.pop()!
        total += roll
        return total
    }
}
