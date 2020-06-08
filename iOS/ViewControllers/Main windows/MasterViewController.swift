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
    var newCreatureObserver: NSObjectProtocol? = nil
  
    @IBOutlet var noResultsView: UIView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
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

        tableView.backgroundView = noResultsView
        
        self.creaturesController = CreaturesController.sharedCreaturesController()
        self.creaturesController?.setDelegate(self)
        
        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main
        self.newCreatureObserver = center.addObserver(forName: NSNotification.Name(rawValue: "selectNewCreature"), object: nil, queue: mainQueue) { (notification) in
            self.newlyCreatedCreature = notification.object as? CreatureModel
            let indexPath = self.creaturesController?.indexPathFromCreature(self.newlyCreatedCreature!)
            if let path = indexPath {
                self.tableView.selectRow(at: path, animated: true, scrollPosition: .middle)
                self.detailViewController?.creature = self.newlyCreatedCreature!
                self.performSegue(withIdentifier: "showDetail", sender: self)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = false
        if let creature = self.detailViewController?.creature {
            self.tableView.selectRow(at: self.creaturesController?.indexPathFromCreature(creature), animated: true, scrollPosition: .middle)
        }
        super.viewWillAppear(animated)
    }

    @objc func insertNewObject(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let wizardViewController = storyboard.instantiateViewController(withIdentifier: "Wizard")
        self.present(wizardViewController, animated: true, completion: nil)
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
            controller.creature = creature
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            self.detailViewController = controller
        }
    }

    func totalEntries() -> Int {
        var total = 0
        if let sectionsArray = self.creaturesController!.context.fetchedResultsController!.sections {
            let sections = sectionsArray.count
            for i in 0..<sections {
                let sectionInfo = sectionsArray[i]
                total += sectionInfo.numberOfObjects
            }
        }
    
        return total
    }
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        var sections = self.creaturesController!.context.fetchedResultsController!.sections?.count ?? 0
        let itemCount = totalEntries()

        if (itemCount == 0) {
            sections = 0
            tableView.separatorStyle = .none
            noResultsLabel.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            noResultsLabel.isHidden = true
        }
        return sections
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        @unknown default:
            return
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
        if let creature = self.detailViewController?.creature {
            let indexPath = self.creaturesController?.indexPathFromCreature(creature)
            if let path = indexPath {
                self.tableView.selectRow(at: path, animated: true, scrollPosition: .middle)
                return
            }
        }
        self.detailViewController?.creature = nil
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self.newCreatureObserver as Any)
    }
}

