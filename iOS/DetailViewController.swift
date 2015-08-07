//
//  DetailViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2014-2015 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

var myContext = UnsafeMutablePointer<()>()

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
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return  delegate.creaturesController
    }()
    
    func configureView() {
        // Update the user interface for the detail item.
        var name = "";
        
        if (self.creature != nil) {
            name = self.creature!.name as String
        }
        
        if let nameField = self.nameField {
            if name == "" {
                nameField.hidden = true
            } else {
                nameField.hidden = false
                nameField.text = name
            }
        }
        
        if let navBar = self.navigationBar {
            navBar.title = name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        setNameFromField(self.nameField!)
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        setNameFromField(self.nameField!)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func setNameFromField(nameField : UITextField) {
        if (self.creature != nil) {
            let name = nameField.text!
            let creature = self.creature!
            let creaturesController = self.creaturesController
            creaturesController.saveName(name, forCreature: creature)
        }
    }
    
    func saveFields() {
        if (self.creature != nil) {
            self.setNameFromField(nameField)
        }
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }
    
    func textViewDidChange(textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        self.setNameFromField(self.nameField!)
    }

}

