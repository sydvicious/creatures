//
//  MasterViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2014-2016 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var creaturesController: CreaturesController? = nil
    var newlyCreatedCreature: Creature? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        guard let split = self.splitViewController else { return }
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController

        let traits = self.view.traitCollection
        if (UIDevice.current.userInterfaceIdiom == .pad) || (traits.verticalSizeClass == .regular) {
            self.splitViewController?.preferredDisplayMode = .primaryOverlay
        }
        let delegate = UIApplication.shared.delegate as! AppDelegate
        self.creaturesController = delegate.creaturesController
        self.creaturesController?.setDelegate(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(_ sender: AnyObject) {
        do {
            try self.newlyCreatedCreature = self.creaturesController!.createCreature("<unnamed>")
        } catch {
            // Can't happen.
            abort()
        }
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }

    // MARK: - Segues

    func creatureForSegue() -> Creature? {
        var creature: Creature? = nil
        if let indexPath = self.tableView.indexPathForSelectedRow {
            creature = self.creaturesController!.creatureFromIndexPath(indexPath)
        } else if let newCreature = self.newlyCreatedCreature {
            creature = newCreature
            self.newlyCreatedCreature = nil
        }
        return creature
    }
    
    //override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
    //   print("traitCollectionDidChange")
    //    print(previousTraitCollection)
    //    print("---")
    //    print(self.view.traitCollection)
    //    print(" ")
    //}

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let creature = self.creatureForSegue()
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.saveFields()
            controller.creature = creature
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            self.detailViewController = controller
            
            // From http://stackoverflow.com/questions/27243158/hiding-the-master-view-controller-with-uisplitviewcontroller-in-ios8
            let traits = self.view.traitCollection

            if (traits.verticalSizeClass == .regular) {
                let animations: () -> Void = {
                    self.splitViewController?.preferredDisplayMode = .automatic
                }
                let completion: (Bool) -> Void = { _ in
                    self.splitViewController?.preferredDisplayMode = .primaryHidden
                }
                UIView.animate(withDuration: 0.3, animations: animations, completion: completion)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.creaturesController!.context.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.creaturesController!.context.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.creaturesController!.deleteCreatureAtIndexPath(indexPath)
        }
    }

    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let creature = self.creaturesController!.creatureFromIndexPath(indexPath)
        cell.textLabel!.text = creature.name as String
    }

    // MARK: - Fetched results controller

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: AnyObject, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, atIndexPath: indexPath!)
            case .move:
                tableView.deleteRows(at: [indexPath!], with: .fade)
                tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        self.detailViewController!.saveFields()
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

    // MARK: UISplitViewControllerDelegate
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        self.detailViewController!.saveFields()
    }

}

