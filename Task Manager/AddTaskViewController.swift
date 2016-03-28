//
//  AddTaskViewController.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/22/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    var taskCreated: ((task: Task) -> ())?
    
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var dtSwitch: UISwitch!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        if taskCreated  != nil {
            callTaskCreated()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func callTaskCreated() {
        let dueDate: NSDate? = dtSwitch.on ? dpDate.date : nil
        let task = Task(name: tfMessage.text!, dueDate: dueDate)

        taskCreated!(task: task)
    }
}