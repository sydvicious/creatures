//
//  LoginViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/29/16.
//
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var settingsView: UIView!
    @IBOutlet var fullName: UITextField!
    @IBOutlet var givenName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    
    @IBOutlet var welcomeView: UIView!
    @IBOutlet var welcomeMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        var fullyInitialized = true
        
        if let storedFullNameObject = defaults.object(forKey: "fullName") {
            let storedFullName = storedFullNameObject as! String
            fullName.text = storedFullName
            fullyInitialized = fullyInitialized && (storedFullName != "")
        } else {
            fullyInitialized = false
        }
        
        if let storedGivenNameObject = defaults.object(forKey: "givenName") {
            let storedGivenName = storedGivenNameObject as! String
            givenName.text = storedGivenName
            fullyInitialized = fullyInitialized && (storedGivenName != "")
        } else {
            fullyInitialized = false
        }
        
        if let storedEmailAddressObject = defaults.object(forKey: "emailAddress") {
            let storedEmailAddress = storedEmailAddressObject as! String
            emailAddress.text = storedEmailAddress
            fullyInitialized = fullyInitialized && (storedEmailAddress != "")
        } else {
            fullyInitialized = false
        }

        if fullyInitialized {
            settingsView.isHidden = true
            welcomeView.isHidden = false
            welcomeMessage.text = String(format: "Welcome back, %@!", givenName.text!)
        } else {
            settingsView.isHidden = false
            welcomeView.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(fullName.text!, forKey: "fullName")
        defaults.set(givenName.text!, forKey: "givenName")
        defaults.set(emailAddress.text!, forKey: "emailAddress")
        super.viewWillDisappear(animated)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
