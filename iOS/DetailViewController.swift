//
//  DetailViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2015-2016 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit

var myContext: UnsafeMutablePointer<()>? = nil

class DetailViewController: UIViewController, UITextViewDelegate, UISplitViewControllerDelegate  {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var creature: Creature? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    lazy var creaturesController: CreaturesController = {
        let delegate = UIApplication.shared().delegate as! AppDelegate
        return  delegate.creaturesController
    }()
    
    func configureView() {
        // Update the user interface for the detail item.
        var name = "";
        
        if let creature = self.creature {
            name = creature.name as String
        }
        
        if let nameField = self.nameField {
            if name == "" {
                nameField.isHidden = true
            } else {
                nameField.isHidden = false
                nameField.text = name
            }
        }
        
        if let navBar = self.navigationBar {
            navBar.title = name
        }
    }

    func saveFieldsNotification(_ notification: NSNotification) {
        self.saveFields()
    }
    
    func saveFields() {
        if (self.creature != nil) {
            self.setNameFromField(nameField)
        }
    }
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveFieldsNotification(_:)) , name: NSNotification.Name.UIViewControllerShowDetailTargetDidChange, object: nil)
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.saveFields), userInfo: nil, repeats: true)

        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setNameFromField(self.nameField!)
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    @IBAction func setNameFromField(_ nameField : UITextField) {
        if (self.creature != nil) {
            let creature = self.creature!
            var name = nameField.text!
            name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if (name == "") {
                name = creature.name as String
                nameField.text! = name
            }
            let creaturesController = self.creaturesController
                try! creaturesController.saveName(name, forCreature: creature)
        }
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }
    
}

