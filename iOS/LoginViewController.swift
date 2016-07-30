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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        if let storedFullNameObject = defaults.object(forKey: "fullName") {
            let storedFullName = storedFullNameObject as! String
            fullName.text = storedFullName
        }
        
        if let storedGiveNameObject = defaults.object(forKey: "givenName") {
            let storedGivenName = storedGiveNameObject as! String
            givenName.text = storedGivenName
        }
        
        if let storedEmailAddressObject = defaults.object(forKey: "emailAddress") {
            let storedEmailAddress = storedEmailAddressObject as! String
            emailAddress.text = storedEmailAddress
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
