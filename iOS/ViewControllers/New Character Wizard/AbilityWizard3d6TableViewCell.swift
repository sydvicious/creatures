//
//  AbilityWizard3d6TableViewCell.swift
//  iOS
//
//  Created by Syd Polk on 2/5/19.
//
//  Copyright © 2019 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

class AbilityWizard3d6TableViewCell:  AbilityWizardDiceTableViewCell, AbilityWizardDiceTableCellProtocol {
    
    @IBOutlet weak var d6_1: UIImageView!
    @IBOutlet weak var d6_2: UIImageView!
    @IBOutlet weak var d6_3: UIImageView!
    
    public func setGUI(rolls: [Int]) {
        d6_1!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[0] - 1])
        d6_2!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[1] - 1])
        d6_3!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[2] - 1])
    }
}
