//
//  CreateViewController.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/29.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

var subjectList = [
    "Chinese",
    "Math",
    "English"
]

class CreateViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var test: Testment!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var scoreField: UITextField!
    @IBOutlet weak var testDatePicker: UIDatePicker!
    @IBOutlet weak var subjectPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        scoreField.delegate = self
        subjectPicker.dataSource = self
        subjectPicker.delegate = self
        
        if let test = test {
            navigationItem.title = test.name
            nameField.text = test.name
            scoreField.text = String(test.score)
            switch(test.subject) {
            case .Chinese:
                subjectPicker.selectRow(0, inComponent: 0, animated: false)
            case .Math:
                subjectPicker.selectRow(1, inComponent: 0, animated: false)
            case .English:
                subjectPicker.selectRow(2, inComponent: 0, animated: false)
            default: break
            }
            testDatePicker.date = test.date
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjectList[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameField.text ?? ""
        let score = Double(scoreField.text ?? "")
        var subj: Subjects!
        switch subjectPicker.selectedRow(inComponent: 0) {
        case 0: subj = .Chinese
        case 1: subj = .Math
        case 2: subj = .English
        default: break
        }
        let date = testDatePicker.date
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        test = Testment(name: name, score: score!, subject: subj, date: date)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The CreateViewController is not inside a navigation controller.")
        }
    }

}
