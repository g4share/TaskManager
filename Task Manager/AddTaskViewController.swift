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
    
    @IBOutlet weak var tfMessage: UITextField?
    
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
        let task = Task(name: (tfMessage?.text)!, dueDate: nil)
        taskCreated!(task: task)
    }
}
