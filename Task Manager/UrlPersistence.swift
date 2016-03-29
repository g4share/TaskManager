//
//  UrlPersistence.swift
//  Task Manager
//
//  Created by Ghenadie Munteanu on 3/29/16.
//  Copyright © 2016 Ghenadie Munteanu. All rights reserved.
//

import Foundation

class UrlPersistence {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func read(jsonReceived: (data: NSData) -> ()) {
        let urlPath: NSURL = NSURL(string: "\(baseUrl)/tasks")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: urlPath)
        
        NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            jsonReceived(data: data!)
  
        }
        .resume()
    }
    
    func write(data: String?) {
        if (data == nil) {
            return
        }
    }
}