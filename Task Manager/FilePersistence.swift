//
//  FilePersistence.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/24/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

class FilePersistence {
    let path: String?
    
    init(fileName: String) {
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            path = dir.stringByAppendingPathComponent(fileName)
            return;
        }
        path = nil
    }
    
    func read() -> NSData? {
        do {
            let data = try NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
            return data
        }
        catch let err {
            print (err)
        }
        return nil
    }
    
    func write(data: String?) {
        if (data == nil) {
            return
        }
    }
}