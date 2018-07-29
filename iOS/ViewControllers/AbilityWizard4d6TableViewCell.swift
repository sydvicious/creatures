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
    
    static let image_name = [
        "d6w1.png", "d6w2.png", "d6w3.png", "d6w4.png", "d6w5.png", "d6w6.png"
    ]
        
    public func setGUI(rolls: [Int], minimumIndex: Int) {
        d6_1!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[0] - 1])
        d6_1.alpha = minimumIndex == 0 ? 0.5 : 1.0

        d6_2!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[1] - 1])
        d6_2.alpha = minimumIndex == 1 ? 0.5 : 1.0

        d6_3!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[2] - 1])
        d6_3.alpha = minimumIndex == 2 ? 0.5 : 1.0
        
        d6_4!.image = UIImage.init(named: AbilityWizard4d6TableViewCell.image_name[rolls[3] - 1])
        d6_4.alpha = minimumIndex == 3 ? 0.5 : 1.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
