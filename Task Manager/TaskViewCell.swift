//
//  TaskCell.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/20/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    @IBOutlet weak var lbTaskMessage: UILabel?
    @IBOutlet weak var imgTaskState: UIImageView?
    @IBOutlet weak var imgTaskColor: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func load(task: Task) {
        let delayedTask = isDelayed(task.dueDate)
        
        lbTaskMessage?.text = task.name
        let stateImageName = delayedTask ? "task_old.png" : "task_new.png"
        imgTaskState?.image = UIImage(named: stateImageName)
        
        let taskColor = delayedTask
            ? UIColor(red: 251/255, green: 193/255, blue: 169/255, alpha: 1)
            : UIColor(red: 170/255, green: 224/255, blue: 1, alpha: 1)

        
        imgTaskColor?.backgroundColor = taskColor
    }
    
    func isDelayed(dueDate: NSDate?) -> Bool {
        if dueDate == nil {
            return false
        }
        
        return dueDate?.compare(NSDate()) == .OrderedAscending
    }
}
