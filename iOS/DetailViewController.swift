//
//  DetailViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2014-2015 Bone Jarring Games and Software. All rights reserved.
//

import UIKit
import SnapKit

var myContext = UnsafeMutablePointer<()>()

class DetailViewController: UIViewController, UITextViewDelegate, UISplitViewControllerDelegate  {

    // Views containing data
    @IBOutlet var contentView: UIView!
    lazy var biographyView: UIView = {
        return UIView()
    }()
    var abilityView: UIView?
    var raceView: UIView?
    var classView: UIView?
    var movementView: UIView?
    var combatView: UIView?
    var skillsView: UIView?
    var featsView: UIView?
    var spellsView: UIView?
    var gearView: UIView?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        label.textAlignment = .Right
        return label
    } ()
    
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
        
        if name == "" {
            nameLabel.hidden = true
        } else {
            nameLabel.hidden = false
            nameLabel.text = name
        }
        
        if let navBar = self.navigationBar {
            navBar.title = name
        }
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        biographyView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 1.0, alpha: 0.5)
        biographyView.addSubview(nameLabel)
        if let content = self.contentView {
            content.addSubview(biographyView)
            biographyView.snp_makeConstraints{ make in
                make.top.equalTo(content).offset(5)
                make.left.equalTo(content).offset(5)
                make.right.equalTo(content).offset(-5)
                make.bottom.equalTo(content).offset(-5)
            }
            nameLabel.snp_makeConstraints{ make in
                make.top.equalTo(biographyView).offset(5)
                make.right.equalTo(biographyView).offset(-5)
            }
        }
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        setNameFromField(self.nameLabel)
        super.viewWillDisappear(animated)
    }
    
    @IBAction func setNameFromField(nameLabel : UILabel) {
        if (self.creature != nil) {
            let creature = self.creature!
            var name = nameLabel.text!
            name = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if (name == "") {
                name = creature.name as String
                nameLabel.text! = name
            }
            let creaturesController = self.creaturesController
                try! creaturesController.saveName(name, forCreature: creature)
        }
    }
    
    func saveFields() {
        if (self.creature != nil) {
            self.setNameFromField(nameLabel)
        }
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(textView: UITextView) {
        self.setNameFromField(self.nameLabel)
    }
    
    func textViewDidChange(textView: UITextView) {
        self.setNameFromField(self.nameLabel)
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        self.setNameFromField(self.nameLabel)
    }

}

