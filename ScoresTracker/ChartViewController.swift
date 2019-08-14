//
//  ChartViewController.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/8/13.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import Charts

func date2Int(date: Date) -> Int {
    let timeInterval = date.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}

class ChartViewController: UIViewController {

    var tests = [Testment]()
    
    @IBOutlet weak var scrChart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedTests = loadTests() {
            tests += savedTests
        } else {
            loadSamples()
        }
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadTests() -> [Testment]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Testment.ArchiveURL.path) as? [Testment]
    }
    
    private func loadSamples() {
        
        let simpleTest: Testment = Testment(name: "SimpleTest", score: 99.5, subject: 1, date: Date(timeIntervalSince1970: 0))
        
        tests += [simpleTest]
    }
    
    private func loadData() -> Void {
        var lineChartEntry0 = [ChartDataEntry]()
        var lineChartEntry1 = [ChartDataEntry]()
        var lineChartEntry2 = [ChartDataEntry]()
        for test in tests {
            let value = ChartDataEntry(x: Double(date2Int(date: test.date)),y: test.score)
            switch(test.subject) {
            case 0: lineChartEntry0.append(value)
            case 1: lineChartEntry1.append(value)
            case 2: lineChartEntry2.append(value)
            default: break
            }
        }
        let line0 = LineChartDataSet(entries: lineChartEntry0, label: "Chinese")
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "Math")
        let line2 = LineChartDataSet(entries: lineChartEntry2, label: "English")
        line0.colors = [NSUIColor.brown]
        line1.colors = [NSUIColor.blue]
        line2.colors = [NSUIColor.red]
        
        let data = LineChartData()
        data.addDataSet(line0)
        data.addDataSet(line1)
        data.addDataSet(line2)
        
        scrChart.data = data
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