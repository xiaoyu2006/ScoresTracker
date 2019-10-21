//
//  Test.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/25.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

struct TestPropertyKey {
    static let name = "name"
    static let score = "score"
    static let subject = "subject"
    static let date = "date"
}

class Testment: NSObject, NSCoding {
    var name: String
    var score: Double
    var subject: Int
    var date: Date
    
    init(name: String, score: Double, subject: Int, date: Date) {
        self.name = name
        self.score = score
        self.subject = subject
        self.date = date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: TestPropertyKey.name)
        aCoder.encode(score, forKey: TestPropertyKey.score)
        aCoder.encode(subject, forKey: TestPropertyKey.subject)
        aCoder.encode(date, forKey:  TestPropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let testName = aDecoder.decodeObject(forKey: TestPropertyKey.name)
        let testScore = aDecoder.decodeDouble(forKey: TestPropertyKey.score)
        let testSubject = aDecoder.decodeInteger(forKey: TestPropertyKey.subject)
        let testDate = aDecoder.decodeObject(forKey: TestPropertyKey.date)
        self.init(name: testName as? String ?? "nameError", score: testScore as? Double ?? 0, subject: testSubject as? Int ?? 0, date: testDate as? Date ?? Date(timeIntervalSince1970: 100000))
        // Date & Score & Subject
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tests")
}
