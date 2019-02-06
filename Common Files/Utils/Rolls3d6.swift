//
//  Rolls3d6.swift
//  iOS
//
//  Created by Syd Polk on 2/5/19.
//  Copyright © 2019 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

class Rolls3d6 {
    let rolls = Dice.rolls(number: 3, dieType: 6)
    
    func score() -> Int {
        var score = 0
        for i in 0...2 {
            score += rolls[i]
        }
        return score
    }
}
