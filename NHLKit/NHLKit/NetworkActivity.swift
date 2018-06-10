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
private let serialQueue = DispatchQueue(label: "com.ericito.nhlkit.networkactivity.queue")

public class NetworkActivity {
    
    public class func start() {
        serialQueue.async {
            NetworkActivityCount += 1
            NetworkActivity.updateNetworkStatus()
        }
    }
    
    public class func stop() {
        serialQueue.async {
            NetworkActivityCount -= 1
            NetworkActivity.updateNetworkStatus()
        }
    }
    
    private class func updateNetworkStatus() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = (NetworkActivityCount > 0)
    }
}
