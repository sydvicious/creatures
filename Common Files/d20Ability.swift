//
//  d20Ability.swift
//  Characters
//
//  Created by Syd Polk on 8/27/16.
//
//

import Foundation

protocol d20Ability {
    var baseScore : Int { get set }
    var bonuses : d20Bonuses { get set }
    
}
