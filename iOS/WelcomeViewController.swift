//
//  WelcomeViewController.swift
//  Characters
//
//  Created by Syd Polk on 8/14/16.
//
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeViewText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        
        if let storedGivenNameObject = defaults.object(forKey: "givenName") {
            let givenName = storedGivenNameObject as! String
            print(givenName)
            welcomeViewText.text = String(format: "Welcome back, %@!", givenName)
        }

        // Do any additional setup after loading the view.
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(WelcomeViewController.respondToTimer), userInfo: nil, repeats: false)

        Thread.sleep(forTimeInterval: 1.0)
    }

    func respondToTimer() {
        self.performSegue(withIdentifier: "SplitViewSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
