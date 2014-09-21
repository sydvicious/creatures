//
//  DetailViewController.swift
//  Creatures for iOS
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2014 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

var myContext = UnsafeMutablePointer<()>()

class DetailViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        var name = "";
        if let detail: AnyObject = self.detailItem {
            name = detail.valueForKey("name").description
        }
        
        if let field = self.nameField {
            if name == "" {
                field.hidden = true
            } else {
                field.hidden = false
                field.text = name
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
        if let detail: AnyObject = self.detailItem {
            detail.setValue(nameField.text, forKey: "name")
        }
    }

}

