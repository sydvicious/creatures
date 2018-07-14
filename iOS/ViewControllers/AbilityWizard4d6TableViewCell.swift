//
//  AbilityWizard4d6TableViewCell.swift
//  iOS
//
//  Created by Syd Polk on 7/13/18.
//

import UIKit

class AbilityWizard4d6TableViewCell: UITableViewCell {

    @IBOutlet weak var d6_1: UIImageView!
    @IBOutlet weak var d6_2: UIImageView!
    @IBOutlet weak var d6_3: UIImageView!
    @IBOutlet weak var d6_4: UIImageView!
    
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var modifierLabel: UILabel!
    
    static let image_name = [
        "d6w1.png", "d6w2.png", "d6w3.png", "d6w4.png", "d6w5.png", "d6w6.png"
    ]
    
    var rolls: [Int] = [ 3, 3, 3, 3 ]
    var abilityName: String = ""
    public var ability: d20Ability!
    var score: Int = 9
    
    public func setAbilityText(text: String) {
        self.abilityName = text
        self.ability = d20Ability(name: self.abilityName, score: self.score)
    }
    
    public func roll() {
        self.rolls = Dice.rolls(number: 4, dieType: 6)
        self.score = Dice.takeRolls(rolls: self.rolls, best: 3)
        if (!abilityName.isEmpty) {
            self.ability = d20Ability(name: self.abilityName, score: self.score)
        }
        self.setGUI()
    }
    
    private func setGUI() {
        d6_1!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[self.rolls[0] - 1])
        d6_2!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[self.rolls[1] - 1])
        d6_3!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[self.rolls[2] - 1])
        d6_4!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[self.rolls[3] - 1])
        abilityLabel!.text = abilityName
        scoreLabel!.text = String(ability.currentScore)
        modifierLabel!.text = String(ability.currentModifer())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
