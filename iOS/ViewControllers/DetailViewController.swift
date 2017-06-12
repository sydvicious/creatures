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
    
    var creature: CreatureModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    lazy var creaturesController: CreaturesController = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return  delegate.creaturesController
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

        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setNameFromField(self.nameField!)
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

