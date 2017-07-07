//
//  WizardSetAbilityScoresViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//

import UIKit

class WizardSetAbilityScoresViewController: UIViewController, UITextFieldDelegate {
    
    private var abilities : [String:Ability] = [:]
    
    @IBOutlet weak var str_field: UITextField!
    @IBOutlet weak var dex_field: UITextField!
    @IBOutlet weak var con_field: UITextField!
    @IBOutlet weak var int_field: UITextField!
    @IBOutlet weak var wis_field: UITextField!
    @IBOutlet weak var cha_field: UITextField!
    
    @IBOutlet weak var str_mod: UILabel!
    @IBOutlet weak var dex_mod: UILabel!
    @IBOutlet weak var con_mod: UILabel!
    @IBOutlet weak var int_mod: UILabel!
    @IBOutlet weak var wis_mod: UILabel!
    @IBOutlet weak var cha_mod: UILabel!
    
    var fields: [String:UITextField?] = [:]
    var labels: [String:UILabel?] = [:]
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        fields = [
            "strength": str_field,
            "dexterity": dex_field,
            "constitution": con_field,
            "intelligence": int_field,
            "wisdom": wis_field,
            "charisma": cha_field
        ]
        for field in fields {
            field.value?.delegate = self
        }
        
        labels = [
            "strength": str_mod,
            "dexterity": dex_mod,
            "constitution": con_mod,
            "intelligence": int_mod,
            "wisdom": wis_mod,
            "charisma": cha_mod
        ]
    }
    
    func setAbilityValues() {
        for ability in d20Ability.abilityKeys {
            abilities[ability] = PathfinderAbility(name: ability, score: Int((fields[ability]??.text!)!)!)
        }
    }
    
    func setDataFor(_ textField: UITextField, score: Int) {
        for field in fields {
            if field.value == textField {
                abilities[field.key] = PathfinderAbility(name: field.key, score: score)
                
                let modifier = d20Ability.modifier(value: score)
                let modifier_string = modifier < 0 ? "\(modifier)" : "+\(modifier)"
                if let label = labels[field.key] {
                    label!.text = modifier_string
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let score = Int(string) {
            if score < 0 {
                return false
            }
            if score > 99 {
                return false
            }
            setDataFor(textField, score: score)
            return true
        }
        return false
    }
}
