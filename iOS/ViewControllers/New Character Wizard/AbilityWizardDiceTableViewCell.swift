//
//  AbilityWizardDiceTableViewCell.swift
//  iOS
//
//  Created by Syd Polk on 2/5/19.
//  Copyright © 2019 Bone Jarring Games and Software. All rights reserved.
//

import Foundation
import UIKit


class AbilityWizardDiceTableViewCell: UITableViewCell {
    
    static let image_name = [
        "d6w1.png", "d6w2.png", "d6w3.png", "d6w4.png", "d6w5.png", "d6w6.png"
    ]
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

protocol AbilityWizardDiceTableCellProtocol {
    func setGUI(rolls: [Int])
}
