//
//  FileDataReceiver.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/23/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

class UrlDataReceiver: DataRceiver {

    let persistence: UrlPersistence = UrlPersistence(baseUrl: "http://172.16.47.4:8080/taskManager")
    var tasks = [Task]()
    
    func reloadTasks(tasksReceived: () -> ()) {
        persistence.read() {
            self.processJson($0)
            tasksReceived()
        }
    }
    
    func processJson(data: NSData?) {
        tasks.removeAll()
        
        do {
            let jsonTasks = try (NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
            for jsonTask in jsonTasks as! [Dictionary<String, String>] {
                tasks.append(Task(fromJson: jsonTask))
            }
            

        } catch let err {
            print(err)
        }
    }
    
    func getTasks() -> [Task]? {
        return tasks;
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