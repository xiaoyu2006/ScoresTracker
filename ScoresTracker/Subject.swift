//
//  Test.swift
//  ScoresTracker
//
//  Created by Nemo on 2019/10/19.
//  Copyright © 2019 Nemo. All rights reserved.
//

import UIKit
import os.log

struct SubjectPropertyKey {
    static let name = "name"
    static let id = "id"
}

class Subject: NSObject, NSCoding {
    var name: String
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SubjectPropertyKey.name)
        aCoder.encode(id, forKey: SubjectPropertyKey.id)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let subjName = aDecoder.decodeObject(forKey: SubjectPropertyKey.name)
        let subjId = aDecoder.decodeDouble(forKey: SubjectPropertyKey.id)
        self.init(name: subjName as! String, id: subjId as! Int)
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("subjs")
}
