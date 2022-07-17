//
//  Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//  Copyright (c) 2016-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//  Copyright © 2022 Syd Polk (reassigned). All rights reserved.
//

import Foundation

class Ability: Equatable, Hashable {
    
    private var _baseScore: Int

    var baseScore: Int {
        get {
            return self._baseScore
        }
    }

    var currentScore: Int {
        get {
            return baseScore
        }
    }

    init(score: Int) {
        if (score < 0) {
            self._baseScore = 0
        } else {
            self._baseScore = score
        }
    }
    
    static func == (lhs: Ability, rhs: Ability) -> Bool {
        return lhs._baseScore == rhs._baseScore
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_baseScore)
    }
}


