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
    let receiver: DataRceiver = FileDataReceiver()
    
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
        receiver.removeTask(indexPath.row) {
            self.taskRemoved($0)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTaskAction" {
            let addView = segue.destinationViewController as! AddTaskViewController
            addView.taskCreated = {
                self.receiver.addTask($0) {
                    self.taskAdded($0)
                }
            }
        }
    }
    
    func taskAdded(task: Task) {
        self.refreshTasks()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.tasks.count - 1, inSection: 0)], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }
    }
    
    func taskRemoved(id: Int) {
        self.refreshTasks()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: id, inSection: 0)], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }
    }
    
    func refreshTasks() {
        receiver.getTasks {
            self.tasks = $0!
        }
    }
}