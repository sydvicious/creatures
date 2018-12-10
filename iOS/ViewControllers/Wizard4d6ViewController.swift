//
//  Wizard4d6ViewController.swift
//  iOS
//
//  Created by Syd Polk on 7/6/18.
//  Copyright © 2018 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

protocol Wizard4d6ViewControllerDelegate {
    func setRolls(withRolls: [Rolls4d6])
}

class Wizard4d6ViewController: UIViewController, Wizard4d6ViewControllerDelegate {
    var wizardViewController: WizardPageViewController? = nil

    var rolls = [Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6()]
    var dieRollsTableViewController: AbilityWizard4d6TableViewController? = nil
    var abilityDisplayTableViewController: AbilityDisplayTableViewController? = nil

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wizardViewController = self.parent as? WizardPageViewController

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reroll(_ sender: Any) {
        let rolls = [Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6(), Rolls4d6()]
        setRolls(withRolls: rolls)
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
                controller.setDelegate(delegate: self)
            }
        } else if segue.identifier == "AbilityDisplay" {
            abilityDisplayTableViewController = segue.destination as? AbilityDisplayTableViewController
            if let controller = abilityDisplayTableViewController {
                controller.setRolls(rolls: self.rolls)
            }
        }
    }
    
    // Wizard4d6ViewControllerDelegate
    func setRolls(withRolls: [Rolls4d6]) {
        self.rolls = withRolls
        if let dieRollsController = dieRollsTableViewController {
            dieRollsController.setRolls(rolls: self.rolls)
        }
        if let abilityDisplayController = abilityDisplayTableViewController {
            abilityDisplayController.setRolls(rolls: self.rolls)
        }

    }
}
