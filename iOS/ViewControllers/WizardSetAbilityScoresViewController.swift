//
//  WizardSetAbilityScoresViewController.swift
//  iOS
//
//  Created by Syd Polk on 6/24/17.
//

import UIKit

class WizardSetAbilityScoresViewController: UIViewController {

    private var strength: PathfinderAbility = PathfinderAbility.init(name: "strength", score: 10)
    private var dexterity: PathfinderAbility = PathfinderAbility.init(name: "dexterity", score: 10)
    private var constitution: PathfinderAbility = PathfinderAbility.init(name: "constitution", score: 10)
    private var intelligence: PathfinderAbility = PathfinderAbility.init(name: "intelligence", score: 10)
    private var wisdom: PathfinderAbility = PathfinderAbility.init(name: "wisdom", score: 10)
    private var charisma: PathfinderAbility = PathfinderAbility.init(name: "charisman", score: 10)
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        self.setView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setView() {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
