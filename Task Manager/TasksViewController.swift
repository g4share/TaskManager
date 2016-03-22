//
//  TasksViewController.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/16/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {
    var tasks = [Task]()
    let receiver: DataRceiver = MemoryDataReceiver()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshTasks()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskViewCell
        cell.load(tasks[indexPath.row])
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        receiver.removeTask(indexPath.row, taskRemoved: {
            self.refreshTasks()
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTaskAction" {
            let addView = segue.destinationViewController as! AddTaskViewController
            addView.taskCreated = { (task: Task) -> () in
                self.receiver.addTask(task, taskAdded: self.taskAdded)
            }
        }
    }
    
    func taskAdded(task: Task) {
        self.refreshTasks()
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: tasks.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    func refreshTasks() {
        receiver.getTasks { (tasks: [Task]?) -> () in
            self.tasks = tasks!
        }
    }
}