//
//  WizardBioIPhoneViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//

import UIKit

class WizardBioViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var wizardViewController: WizardPageViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wizardViewController = self.parent as? WizardPageViewController
        nameField!.text = wizardViewController?.protoData?.name
        nameField!.delegate = self
        setDoneButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        wizardViewController?.protoData?.name = nameField!.text!
    }

    func setDoneButton() {
        doneButton.isEnabled = (wizardViewController?.isCharacterReady())!
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.cancel()
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        wizardViewController?.done()
    }
    
    // MARK UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        wizardViewController?.protoData?.name = textField.text!
        setDoneButton()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setDoneButton()
        return true
    }
}
