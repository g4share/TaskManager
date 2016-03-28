//
//  FileDataReceiver.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/23/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

class FileDataReceiver: DataRceiver {

    let persistence: FilePersistence = FilePersistence(fileName: "tasks.json")
    var tasks = [Task]()

    
    func getTasks(tasksReceived: (tasks: [Task]?) -> ()) {
        let data = persistence.read()
        do {
            let jsonTasks = try (NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
            for jsonTask in jsonTasks as! [Dictionary<String, String>] {
                tasks.append(Task(fromJson: jsonTask))
            }
            
            tasksReceived(tasks: tasks)
        } catch let err {
            print(err)
        }
    }
    
    func addTask(task: Task, taskAdded: (task: Task) -> ()) {
        tasks.append(task)
        taskAdded(task: task)
    }
    
    func removeTask(id: Int, taskRemoved: (id: Int) -> ()) {
        tasks.removeAtIndex(id)
        taskRemoved(id: id)
    }
}