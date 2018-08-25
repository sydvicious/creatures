//
//  Wizard4d6ViewController.swift
//  iOS
//
//  Created by Syd Polk on 7/6/18.
//  Copyright © 2018 Bone Jarring Games and Software. All rights reserved.
//

import UIKit


class Wizard4d6ViewController: UIViewController {
    var wizardViewController: WizardPageViewController? = nil

    var rolls = [Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6()]
    var dieRollsTableViewController: AbilityWizard4d6TableViewController? = nil
    var abilityDisplayTableViewController: AbilityDisplayTableViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        wizardViewController = self.parent as? WizardPageViewController

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reroll(_ sender: Any) {
        self.rolls = [Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6()]
        if let dieRollsController = dieRollsTableViewController {
            dieRollsController.setRolls(rolls: self.rolls)
        }
        if let abilityDisplayController = abilityDisplayTableViewController {
            abilityDisplayController.setRolls(rolls: self.rolls)
        }
    }
    
    func setAbilityValues() {
        var abilities: [Abilities:Int] = [:]
        for i in 0...5 {
            let ability = d20Ability.abilityKeys[i]
            let score = rolls[i].score()
            abilities[ability] = score
        }
        wizardViewController?.protoData?.abilities = abilities
    }

    @IBAction func doDoneButton(_ sender: Any) {
        setAbilityValues()
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.done()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AbilityWizard4d6" {
            dieRollsTableViewController = segue.destination as? AbilityWizard4d6TableViewController
            if let controller = dieRollsTableViewController {
                controller.setRolls(rolls: self.rolls)
            }
        } else if segue.identifier == "AbilityDisplay" {
            abilityDisplayTableViewController = segue.destination as? AbilityDisplayTableViewController
            if let controller = abilityDisplayTableViewController {
                controller.setRolls(rolls: self.rolls)
            }
        }
    }
}
