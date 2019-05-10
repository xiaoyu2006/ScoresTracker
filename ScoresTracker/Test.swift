//
//  Test.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/25.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

struct PropertyKey {
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
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(score, forKey: PropertyKey.score)
        aCoder.encode(subject, forKey: PropertyKey.subject)
        aCoder.encode(date, forKey:  PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let testName = aDecoder.decodeObject(forKey: PropertyKey.name)
        let testScore = aDecoder.decodeDouble(forKey: PropertyKey.score)
        let testSubject = aDecoder.decodeInteger(forKey: PropertyKey.subject)
        let testDate = aDecoder.decodeObject(forKey: PropertyKey.date)
        self.init(name: testName as? String ?? "nameError", score: testScore as? Double ?? 0, subject: testSubject as? Int ?? 0, date: testDate as? Date ?? Date(timeIntervalSince1970: 100000))
        // Date & Score & Subject
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tests")
}
