//
//  DataReceiver.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/17/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

protocol DataRceiver {
    func getTasks(tasksReceived: (tasks: [Task]?) -> ())
    func removeTask(id: Int, taskRemoved: () -> ())
}