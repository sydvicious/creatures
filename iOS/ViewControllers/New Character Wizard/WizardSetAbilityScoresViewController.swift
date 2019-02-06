//
//  WizardSetAbilityScoresViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//  Copyright © 2017 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

class WizardSetAbilityScoresViewController: UIViewController, UITextFieldDelegate {
    
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
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var wizardViewController: WizardPageViewController? = nil

    var fields: [Abilities:UITextField?] = [:]
    var labels: [Abilities:UILabel?] = [:]
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        wizardViewController = self.parent as? WizardPageViewController

        fields = [
            .Strength: str_field,
            .Dexterity: dex_field,
            .Constitution: con_field,
            .Intelligence: int_field,
            .Wisdom: wis_field,
            .Charisma: cha_field
        ]
        for field in fields {
            field.value?.delegate = self
        }
        
        labels = [
            .Strength: str_mod,
            .Dexterity: dex_mod,
            .Constitution: con_mod,
            .Intelligence: int_mod,
            .Wisdom: wis_mod,
            .Charisma: cha_mod
        ]

        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
    }
    
    func setAbilityValues() {
        for ability in d20Ability.abilityKeys {
            guard let field = fields[ability] else { continue }
            guard let scoreText = field?.text else { continue }
            guard let score = Int(scoreText) else { continue }
            wizardViewController?.protoData?.abilities[ability] = score
        }
    }
    
    func setDataFor(_ textField: UITextField, score: Int) {
        for field in fields {
            if field.value == textField {
                wizardViewController?.protoData?.abilities[field.key] = score
                
                let modifier = d20Ability.modifier(value: score)
                let modifier_string = modifier < 0 ? "\(modifier)" : "+\(modifier)"
                if let label = labels[field.key] {
                    label!.text = modifier_string
                }
                break
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var valid = false
        if let currentString = textField.text {
            let stringCopy = currentString as NSString?
            if let proposedString = stringCopy?.replacingCharacters(in: range, with: string) {
                if let score = Int(proposedString) {
                    if score >= 0 && score < 100 {
                        setDataFor(textField, score: score)
                        valid = true
                    }
                } else if proposedString == "" {
                    valid = true
                }
            }
        }
        if valid {
            doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
        }
        return valid
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let string = textField.text {
            if let score = Int(string) {
                setDataFor(textField, score: score)
            }
        }
        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let string = textField.text {
            if let score = Int(string) {
                setDataFor(textField, score: score)
            }
        }
        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.cancel()
    }
    
    @IBAction func doDoneButton(_ sender: Any) {
        setAbilityValues()
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.done()
    }
}
