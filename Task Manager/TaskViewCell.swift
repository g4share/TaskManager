//
//  TaskCell.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/20/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var lbTaskMessage: UILabel!
    @IBOutlet weak var imgTaskState: UIImageView!
    @IBOutlet weak var imgTaskColor: UIImageView!
    
    let redColor = UIColor(red: 251/255, green: 193/255, blue: 169/255, alpha: 1)
    let blueColor = UIColor(red: 170/255, green: 224/255, blue: 1, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func load(task: Task) {
        lbTaskMessage.text = task.name
        
        let delayedTask = isDelayed(task.dueDate)
        imgTaskState.image = UIImage(named: delayedTask ? "task_old.png" : "task_new.png")
        imgTaskColor.backgroundColor = delayedTask ? redColor : blueColor
    }
    
    func isDelayed(dueDate: NSDate?) -> Bool {
        if dueDate == nil {
            return false
        }
    
        return NSCalendar.currentCalendar().compareDate(dueDate!,
                                                 toDate: NSDate(),
                                                 toUnitGranularity: .Day) == .OrderedAscending
    }
}