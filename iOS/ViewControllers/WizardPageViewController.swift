//
//  WizardPageViewController.swift
//  Characters
//
//  Created by Syd Polk on 11/10/16.
//  Copyright (c) 2016 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit

var wizardCreature = Creature()
var wizardName = "<untitled>"

private var wizardIPhoneViewControllerNames = [
    "WizardIntroIPhone",
    "WizardBioIPhone"
]

private var wizardiPadViewControllerNames = [
    "WizardIntroIPad"
]

private (set) var wizardViewControllers: [UIViewController] = {
    var controllers: [UIViewController] = []
    var controllerNames = UIDevice.current.userInterfaceIdiom == .pad ? wizardiPadViewControllerNames : wizardIPhoneViewControllerNames
    for name in controllerNames {
        controllers.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name))
    }
    return controllers
}()

class WizardPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        // Do any additional setup after loading the view.
        
        if let firstViewController = wizardViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
