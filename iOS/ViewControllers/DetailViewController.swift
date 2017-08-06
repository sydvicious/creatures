//
//  DetailViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2015-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit

var myContext: UnsafeMutableRawPointer? = nil

class DetailViewController: UIViewController, UISplitViewControllerDelegate  {

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
        if let navBar = self.navigationBar {
            navBar.title = name
        }
        
        for ability in d20Ability.abilityKeys {
            guard let score = creature?.creature?.abilityScoreFor(ability) else { return }
            abilityLabels[ability]??.text = "\(score)"
            let modifier = d20Ability.modifier(value: score)
            let modifier_string = modifier < 0 ? "\(modifier)" : "+\(modifier)"
            abilityModLabels[ability]??.text = modifier_string
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
}

