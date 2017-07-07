//
//  MasterViewController.swift
//  Characters
//
//  Created by Syd Polk on 7/18/14.
//  Copyright (c) 2014-2017 Bone Jarring Games and Software, LLC. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISplitViewControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var creaturesController: CreaturesController? = nil
    var newlyCreatedCreature: CreatureModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        guard let split = self.splitViewController else { return }
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController

        self.splitViewController?.preferredDisplayMode = .allVisible

        let delegate = UIApplication.shared.delegate as! AppDelegate
        self.creaturesController = delegate.creaturesController
        self.creaturesController?.setDelegate(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = false
        if let creature = self.detailViewController?.creature {
            self.tableView.selectRow(at: self.creaturesController?.indexPathFromCreature(creature), animated: true, scrollPosition: .middle)
        }
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func insertNewObject(_ sender: AnyObject) {
        do {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let wizardViewController = storyboard.instantiateViewController(withIdentifier: "Wizard")
            self.present(wizardViewController, animated: true, completion: nil)
//            try self.newlyCreatedCreature = self.creaturesController!.createCreature("<unnamed>")
        } catch {
            // Can't happen.
            abort()
        }
    }

    // MARK: - Segues

    func creatureForSegue() -> CreatureModel? {
        var creature: CreatureModel? = nil
        if let indexPath = self.tableView.indexPathForSelectedRow {
            creature = self.creaturesController!.creatureFromIndexPath(indexPath)
        } else if let newCreature = self.newlyCreatedCreature {
            creature = newCreature
        }
        return creature
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let creature = self.creatureForSegue()
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.saveFields()
            controller.creature = creature
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            self.detailViewController = controller
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.creaturesController!.context.fetchedResultsController!.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.creaturesController!.context.fetchedResultsController?.sections![section]
        return sectionInfo!.numberOfObjects
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
        } else if editingStyle == .insert {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        }
    }

    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        let creature = self.creaturesController!.creatureFromIndexPath(indexPath)
        cell.textLabel!.text = creature.name! as String
    }

    // MARK: - Fetched results controller

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

    @nonobjc func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: AnyObject, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
                let rows = tableView.numberOfRows(inSection: 0)
                if (rows > 0) {
                    tableView.selectRow(at: newIndexPath!, animated: true, scrollPosition: .middle)
                }
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, atIndexPath: indexPath!)
            case .move:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, atIndexPath: indexPath!)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
        if let creature = self.detailViewController?.creature {
            self.tableView.selectRow(at: self.creaturesController?.indexPathFromCreature(creature), animated: true, scrollPosition: .middle)
        }
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        self.detailViewController!.saveFields()
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    // MARK: UISplitViewControllerDelegate
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        self.detailViewController!.saveFields()
    }

}

