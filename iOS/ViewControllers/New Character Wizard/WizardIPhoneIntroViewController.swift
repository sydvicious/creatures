//
//  WizardIPhoneIntroViewController.swift
//  iOS
//
//  Created by Sydney Polk on 8/5/17.
//  Copyright © 2017 Bone Jarring Games and Software. All rights reserved.
//

import UIKit

class WizardIPhoneIntroViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!

    var wizardViewController: WizardPageViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        wizardViewController = self.parent as? WizardPageViewController
        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.cancel()
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.done()
    }
}
