//
//  WizardPageViewController.swift
//  Characters
//
//  Created by Syd Polk on 11/10/16.
//  Copyright (c) 2016 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit

private var wizardIPhoneViewControllerNames = [
    "WizardIntroIPhone",
    "WizardBioIPhone",
    "WizardSetAbiltiesIPhone"
]

private var wizardiPadViewControllerNames = [
    //"WizardIntroIPad"
    "WizardIntroIPhone",
    "WizardBioIPhone",
    "WizardSetAbiltiesIPhone"
]

private (set) var wizardViewControllers: [UIViewController] = {
    var controllers: [UIViewController] = []
    var controllerNames = UIDevice.current.userInterfaceIdiom == .pad ? wizardiPadViewControllerNames : wizardIPhoneViewControllerNames
    for name in controllerNames {
        controllers.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name))
    }
    return controllers
}()

struct WizardCreatureProtoData {
    var name: String = ""
    var abilities : [Abilities:Int] = [:]
}


class WizardPageViewController: UIPageViewController {

    var protoData : WizardCreatureProtoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        // Do any additional setup after loading the view.
        
        protoData = WizardCreatureProtoData()
        if let firstViewController = wizardViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isCharacterReady() -> Bool {
        let name = protoData?.name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if "" == name {
            return false
        }
        for key in d20Ability.abilityKeys {
            guard let _ = protoData?.abilities[key] else {
                return false
            }
        }
        return true
    }

    func cancel() {
        NSLog("Put up an alert here!")
        protoData = nil
        self.dismiss(animated: true, completion: nil)
    }

    func done() {
        // Set up the creature in the controller and dismiss the wizard.
        // Will not exit if any of the data validation fails.
        
        do {
            var creatureBuilder = CreatureBuilder()
            creatureBuilder = creatureBuilder.set(system: "Pathfinder")
            for key in d20Ability.abilityKeys {
                let score = protoData?.abilities[key]!
                creatureBuilder = creatureBuilder.set(abilityFor: key, score: score!)
            }
            let creature = try creatureBuilder.build()
            let creaturesController = CreaturesController.sharedCreaturesController()
            _ = try creaturesController.createCreature((protoData?.name)!, withSystem: "Pathfinder", withCreature: creature)
        } catch {
            NSLog("Unable to create a creature")
        }
        
        protoData = nil
        self.dismiss(animated: true, completion: nil)
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

// MARK: UIPageViewControllerDataSource

extension WizardPageViewController: UIPageViewControllerDataSource {
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = wizardViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard wizardViewControllers.count > previousIndex else {
            return nil
        }
        
        return wizardViewControllers[previousIndex]
    }
    
    @available(iOS 5.0, *)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = wizardViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let count = wizardViewControllers.count
        
        guard count != nextIndex else {
            return nil
        }
        
        guard count > nextIndex else {
            return nil
        }
        
        return wizardViewControllers[nextIndex]
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return wizardViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = wizardViewControllers.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
}
