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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskViewCell
        
        let task = tasks[indexPath.row]
        cell.load(task)
                
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        receiver.removeTask(indexPath.row, taskRemoved: { () -> () in
            self.refreshTasks()
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        })
    }
    
    func refreshTasks() {
        receiver.getTasks({ (tasks: [Task]?) -> () in
            self.tasks = tasks!
        })
    }
}