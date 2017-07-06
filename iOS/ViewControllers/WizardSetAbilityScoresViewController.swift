//
//  WizardSetAbilityScoresViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//

import UIKit

class WizardSetAbilityScoresViewController: UIViewController, UITextFieldDelegate {
    
    private var abilities : [String:Ability] = [:]
    
    @IBOutlet var str_field: UITextField?
    @IBOutlet var dex_field: UITextField?
    @IBOutlet var con_field: UITextField?
    @IBOutlet var int_field: UITextField?
    @IBOutlet var wis_field: UITextField?
    @IBOutlet var cha_field: UITextField?
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
    }
    
    func setAbilityValues() {
        for ability in ["strength", "dexterity", "constitution", "intelligence", "wisdom", "charisma"] {
            abilities[ability] = PathfinderAbility(name: ability, score: Int(str_field!.text!)!)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let value = Int(string) {
            if value < 0 {
                return false
            }
            if value > 99 {
                return false
            }
            return true
        }
        return false
    }
}
