//
//  TableViewController.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/29.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

let subjectList = [
    NSLocalizedString("Chinese", comment: "Chinese"),
    NSLocalizedString("Math", comment: "Math"),
    NSLocalizedString("English", comment: "English")
]

class TableViewController: UITableViewController {

    var tests = [Testment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let savedTests = loadTests() {
            tests += savedTests
        } else {
            loadSamples()
        }
    }

    private func loadSamples() {
        
        let simpleTest: Testment = Testment(name: "SimpleTest", score: 99.5, subject: 1, date: Date(timeIntervalSince1970: 0))
        
        tests += [simpleTest]
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let test = tests[indexPath.row]
        
        cell.scoreLabel.text = String(test.score)
        cell.nameLabel.text = test.name
        switch(test.subject) {
        case 0: cell.subjectLabel.text = subjectList[0]
        case 1: cell.subjectLabel.text = subjectList[1]
        case 2: cell.subjectLabel.text = subjectList[2]
        default: break
        }
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let myFormatter = DateFormatter()
        myFormatter.timeZone = timeZone
        myFormatter.dateFormat = "yyyy-MM-dd"
        //...
        let date: String = myFormatter.string(from: test.date)
        cell.dateLabel.text = date
        
        return cell
    }
    

    @IBAction func unwindToTestList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreateViewController, let test = sourceViewController.test {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing test.
                tests[selectedIndexPath.row] = test
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new test.
                let newIndexPath = IndexPath(row: tests.count, section: 0)
                
                tests.append(test)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveTests()
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tests.remove(at: indexPath.row)
            saveTests()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new testment.", log: OSLog.default, type: .debug)
        
        case "ShowDetail":
            guard let DetailViewController = segue.destination as? CreateViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? TableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedTest = tests[indexPath.row]
            DetailViewController.test = selectedTest
        
        case "ShowChart":
            break
        
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

    
    private func saveTests() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tests, toFile: Testment.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Tests successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save tests...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTests() -> [Testment]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Testment.ArchiveURL.path) as? [Testment]
    }

    
}
