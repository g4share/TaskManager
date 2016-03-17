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

        receiver.getTasks({ (tasks: [Task]?) -> () in
            self.tasks = tasks!
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as UITableViewCell
        let task = self.tasks[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        return cell;
    }
}