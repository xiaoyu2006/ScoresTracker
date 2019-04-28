//
//  TableViewController.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/29.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

class TableViewController: UITableViewController {

    var tests = [Testment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadSamples()
    }

    private func loadSamples() {
        
        let simpleTest: Testment = Testment(name: "SimpleTest", score: 99.5, subject: .Math, date: Date(timeIntervalSince1970: 0))
        
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
        case .Chinese: cell.subjectLabel.text = "Chinese"
        case .Math: cell.subjectLabel.text = "Math"
        case .English: cell.subjectLabel.text = "English"
        default: break
        }
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let myFormatter = DateFormatter()
        myFormatter.timeZone = timeZone
        myFormatter.dateFormat = "yy-MM-dd HH"
        //...
        let date: String = myFormatter.string(from: test.date)
        cell.dateLabel.text = date
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        
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
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

}
