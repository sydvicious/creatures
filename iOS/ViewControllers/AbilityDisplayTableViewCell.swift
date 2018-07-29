//
//  AbilityDisplayTableViewCell.swift
//  iOS
//
//  Created by Syd Polk on 7/26/18.
//

import UIKit

class AbilityDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var modifierLabel: UILabel!
    
    public var ability: String? {
        didSet {
            if let label = abilityLabel {
                label.text = ability
            }
        }
    }
    
    public var score: Int? {
        didSet {
            if let unwrappedScore = score {
                if let label = scoreLabel {
                    label.text = String(unwrappedScore)
                }
                let modifierString = d20Ability.modifierString(value: unwrappedScore)
                if let label = modifierLabel {
                    label.text = modifierString
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ability = "Strength"
        score = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
