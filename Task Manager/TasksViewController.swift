//
//  TasksViewController.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/16/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {
    
    @IBOutlet weak var aiLoadData: UIActivityIndicatorView?

    @IBAction func refreshButtonTapped(sender: UIButton) {
        refreshTasks()
    }
    
    let receiver: DataRceiver = UrlDataReceiver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTasks()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiver.getTasks()!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskViewCell
        cell.load(receiver.getTasks()![indexPath.row])
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
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.receiver.getTasks()!.count - 1, inSection: 0)],
                                                  withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }
    }
    
    func taskRemoved(id: Int) {        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: id, inSection: 0)], withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }
    }
    
    func refreshTasks() {
        dispatch_async(dispatch_get_main_queue()) {
            self.aiLoadData!.startAnimating()
        }
        
        receiver.reloadTasks {
            dispatch_async(dispatch_get_main_queue()) {
                self.aiLoadData!.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}