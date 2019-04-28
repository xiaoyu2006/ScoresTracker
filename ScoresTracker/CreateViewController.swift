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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        test.name = nameField.text ?? "Test name"
        test.score = Double(scoreField.text ?? "100") ?? 100.0
        print(test.name)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
