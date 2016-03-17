//
//  MemoryDataReceiver.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/17/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

class MemoryDataReceiver: DataRceiver {
    var tasks = [Task]()
    
    init () {
        self.tasks = [Task(name: "Create useless project"),
                      Task(name: "Put it on GitHub"),
                      Task(name: "Share link"),
                      Task(name: "Receive congratulations"),
                      Task(name: "Change a bit"),
                      Task(name: "Learn Swift")]
    }
    
    func getData() -> [Task] {
        return self.tasks
    }
}