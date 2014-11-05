//
//  NetworkActivity.swift
// 
//
//  Created by Eric Ito on 10/21/14.
//  Copyright (c) 2014 Eric Ito. All rights reserved.
//

import Foundation
import UIKit

/// Global count of outstanding network requests
private var NetworkActivityCount = 0

/// This queue will handle all requests to increment/decrement activity count
/// thus ensuring concurrency will be handled correctly
private let serialQueue = dispatch_queue_create("com.ericito.scoreboard.activity.queue", DISPATCH_QUEUE_SERIAL);


public class NetworkActivity {
    
    public class func start() {
        dispatch_async(serialQueue) {
            NetworkActivityCount++
            NetworkActivity.updateNetworkStatus()
        }
    }
    
    public class func stop() {
        dispatch_async(serialQueue) {
            NetworkActivityCount--
            NetworkActivity.updateNetworkStatus()
        }
    }
    
    private class func updateNetworkStatus() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = (NetworkActivityCount > 0)
    }
}