//
//  Test.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/3/25.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit

enum Subjects {
    case Chinese
    case Math
    case English
}

class Testment {
    var name: String
    var score: Double
    var subject: Subjects
    var date: Date
    
    init(name: String, score: Double, subject: Subjects, date: Date) {
        self.name = name
        self.score = score
        self.subject = subject
        self.date = date
    }
}
