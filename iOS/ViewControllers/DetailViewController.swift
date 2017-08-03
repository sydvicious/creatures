//
//  DetailViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2015-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit

var myContext: UnsafeMutableRawPointer? = nil

class DetailViewController: UIViewController, UITextFieldDelegate, UISplitViewControllerDelegate  {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var str_label: UILabel!
    @IBOutlet weak var dex_label: UILabel!
    @IBOutlet weak var con_label: UILabel!
    @IBOutlet weak var int_label: UILabel!
    @IBOutlet weak var wis_label: UILabel!
    @IBOutlet weak var cha_label: UILabel!
    
    @IBOutlet weak var str_mod_label: UILabel!
    @IBOutlet weak var dex_mod_label: UILabel!
    @IBOutlet weak var con_mod_label: UILabel!
    @IBOutlet weak var int_mod_label: UILabel!
    @IBOutlet weak var wis_mod_label: UILabel!
    @IBOutlet weak var cha_mod_label: UILabel!
    
    var abilityLabels: [Abilities:UILabel?] = [:]
    var abilityModLabels: [Abilities:UILabel?] = [:]
    
    var creature: CreatureModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    lazy var creaturesController: CreaturesController = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return CreaturesController.sharedCreaturesController()
    }()
    
    func configureView() {
        // Update the user interface for the detail item.
        var name = "";
        
        if let creature = self.creature {
            name = creature.name! as String
        }
        
        if let nameField = self.nameField {
            if name == "" {
                nameField.isHidden = true
            } else {
                nameField.isHidden = false
                nameField.text = name
            }
            nameField.delegate = self
        }
        
        for ability in d20Ability.abilityKeys {
            guard let score = creature?.creature?.abilityScoreFor(ability) else { return }
            abilityLabels[ability]??.text = "\(score)"
            let modifier = d20Ability.modifier(value: score)
            let modifier_string = modifier < 0 ? "\(modifier)" : "+\(modifier)"
            abilityModLabels[ability]??.text = modifier_string
        }
        
        if let navBar = self.navigationBar {
            navBar.title = name
        }
    }

    func saveFields() {
        if (self.creature != nil) {
            if let field = nameField {
                self.setNameFromField(field)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        abilityLabels[.Strength] = str_label
        abilityModLabels[.Strength] = str_mod_label
        
        abilityLabels[.Dexterity] = dex_label
        abilityModLabels[.Dexterity] = dex_mod_label
        
        abilityLabels[.Constitution] = con_label
        abilityModLabels[.Constitution] = con_mod_label
        
        abilityLabels[.Intelligence] = int_label
        abilityModLabels[.Intelligence] = int_mod_label
        
        abilityLabels[.Wisdom] = wis_label
        abilityModLabels[.Wisdom] = wis_mod_label
        
        abilityLabels[.Charisma] = cha_label
        abilityModLabels[.Charisma] = cha_mod_label
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let newName = self.nameField {
            self.setNameFromField(newName)
        }
        super.viewWillDisappear(animated)
    }
    
    @IBAction func setNameFromField(_ nameField : UITextField) {
        if let creature = self.creature {
            var name = nameField.text!
            name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if (name == "") {
                name = creature.name!
                nameField.text! = name
            }
            let creaturesController = self.creaturesController
            try! creaturesController.saveName(name, forCreature: creature)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.nameField.returnKeyType = .done
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.setNameFromField(nameField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let navBar = self.navigationBar {
            navBar.title = nameField.text!
        }
        nameField.resignFirstResponder()
        return false
    }

}

