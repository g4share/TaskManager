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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.tasks = [Task(name: "Create useless project", dueDate: dateFormatter.dateFromString("2001-01-01")!),
                      Task(name: "Put it on GitHub", dueDate: dateFormatter.dateFromString("2001-01-01")!),
                      Task(name: "Share link", dueDate: dateFormatter.dateFromString("2018-01-01")!),
                      Task(name: "Receive congratulations", dueDate: dateFormatter.dateFromString("2001-01-01")!),
                      Task(name: "Change a bit", dueDate: nil),
                      Task(name: "Learn Swift", dueDate:  nil)]
    }
    
    func getTasks(tasksReceived: (tasks: [Task]?) -> ()) {
        tasksReceived(tasks: tasks)
    }
    
    func removeTask(id: Int, taskRemoved: () -> ()) {
        tasks.removeAtIndex(id)
        taskRemoved()
    }
}