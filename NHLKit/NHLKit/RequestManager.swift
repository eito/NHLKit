//
//  RequestManager.swift
//  disneycars
//
//  Created by Eric Ito on 10/2/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation

public class RequestManager: NSObject, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate {
    
    // MARK: Properties
    
    private var session: NSURLSession!
    
    public class var sharedManager:RequestManager {
        get {
            struct Static {
                static var instance : RequestManager? = nil
            }
            
            if Static.instance == nil {
                Static.instance = RequestManager()
            }
            
            return Static.instance!
        }
    }
    
    // MARK: Initializers
    
    override init() {
        super.init()
        let sessionConfig = NSURLSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    }
    
    // MARK: Methods
    
    public func dataTaskForRequest(request: Request) -> NSURLSessionTask? {
        var dataTask = session.dataTaskWithURL(request.URL)
        return dataTask
    }
}