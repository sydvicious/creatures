//
//  LoginViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/29/16.
//
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var fullName: UITextField!
    @IBOutlet var givenName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    
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
            self.performSegue(withIdentifier: "WelcomeViewSegue", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkData() -> Bool {
        if let name = fullName.text {
            if name == "" {
                return false
            }
        } else {
            return false
        }
        
        if let given = givenName.text {
            if given == "" {
                return false
            }
        } else {
            return false
        }
        
        if let email = emailAddress.text {
            if email == "" {
                return false
            }
        } else {
            return false
        }
        return true
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(fullName.text!, forKey: "fullName")
        defaults.set(givenName.text!, forKey: "givenName")
        defaults.set(emailAddress.text!, forKey: "emailAddress")
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: AnyObject?) -> Bool {
        return self.checkData()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.save()
    }


}
