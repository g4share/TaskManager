//
//  Task.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/16/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

struct Task {
    let name: String
    let dueDate: NSDate?
    
    init(name: String, dueDate: NSDate?) {
        self.name = name
        self.dueDate = dueDate
    }
    
    init(fromJson jsonTask: Dictionary<String, String>) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        name = jsonTask["name"]! as String
        
        if let jsonDate = jsonTask["dueDate"] {
           dueDate = jsonDate == ":now" ? NSDate() : dateFormatter.dateFromString(jsonDate)
        } else {
            dueDate = nil;
        }
    }
    
    var description: String {
        return "\(name) to be done till \(dueDate)"
    }
}